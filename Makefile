# ============================================================
# dotfiles — 冪等な named targets (何度実行しても安全)
# ============================================================
SHELL    := /bin/bash
DOTFILES := $(HOME)/dotfiles
STOW_PKGS := zsh git tmux config
BACKUP   := $(HOME)/dotfiles-backup

.DEFAULT_GOAL := help

.PHONY: help all bootstrap brew link unlink sync mise macos check local

help: ## 利用可能なターゲット一覧
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

all: bootstrap brew link mise local ## 初回フルセットアップ

bootstrap: ## Homebrew 未導入なら導入
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "==> Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else echo "==> Homebrew OK"; fi

brew: ## Brewfile を同期 (formula/cask/tap/font/vscode)
	@echo "==> brew bundle"
	@brew bundle --file=$(DOTFILES)/Brewfile

link: ## stow で symlink を冪等に適用 (既存実ファイルは backup へ退避)
	@echo "==> backing up conflicting real files to $(BACKUP)"
	@for pkg in $(STOW_PKGS); do \
		while IFS= read -r f; do \
			tgt="$(HOME)/$$f"; \
			if [ -e "$$tgt" ] && [ ! -L "$$tgt" ]; then \
				mkdir -p "$$(dirname "$(BACKUP)/$$f")"; \
				mv "$$tgt" "$(BACKUP)/$$f"; \
				echo "  backed up: $$f"; \
			fi; \
		done < <(cd $(DOTFILES)/$$pkg && find . -type f -not -path '*/.git/*' | sed 's|^\./||'); \
	done
	@echo "==> stow $(STOW_PKGS)"
	@cd $(DOTFILES) && stow -R $(STOW_PKGS)
	@$(MAKE) --no-print-directory local

unlink: ## stow の symlink を解除
	@cd $(DOTFILES) && stow -D $(STOW_PKGS)

sync: brew link mise ## リポジトリ最新を反映 (日常用)

mise: ## mise でランタイムをインストール
	@if command -v mise >/dev/null 2>&1; then echo "==> mise install"; mise install; fi

macos: ## macOS のシステム既定値を適用 (キーリピート等)
	@bash $(DOTFILES)/macos/defaults.sh

local: ## .local テンプレ未作成なら案内
	@[ -f $(HOME)/.zshenv.local ]   || echo "ℹ  cp $(DOTFILES)/zsh/.zshenv.local.example ~/.zshenv.local";
	@[ -f $(HOME)/.gitconfig.local ] || echo "ℹ  cp $(DOTFILES)/git/.gitconfig.local.example ~/.gitconfig.local";

check: ## 非破壊チェック (構文 / stow dry-run / 秘密スキャン)
	@echo "==> zsh -n"; zsh -n $(DOTFILES)/zsh/.zshrc && echo "  ok"
	@echo "==> stow dry-run"; cd $(DOTFILES) && stow -nv $(STOW_PKGS)
	@echo "==> secret scan"; \
		if git -C $(DOTFILES) grep -nIE 'ntn_[A-Za-z0-9]|sntryu_[A-Za-z0-9]|_API_TOKEN[[:space:]]*=[[:space:]]*[^ ]' -- . ':!*.example' >/dev/null 2>&1; then \
			echo "  ✗ secret-like string found!"; exit 1; \
		else echo "  ok (no secrets in tracked files)"; fi

# ============================================================
# .zshrc — interactive shell config (modern, no oh-my-zsh)
# 環境変数・秘密情報は .zshenv / ~/.zshenv.local 側で読み込む
# ============================================================

# ---- Homebrew ----
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ---- 補完 (Homebrew の補完パスを追加してから compinit) ----
if (( $+commands[brew] )); then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
fi
autoload -Uz compinit && compinit

# ---- プロンプト: Starship ----
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# ---- バージョン管理: mise ----
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# ---- direnv ----
if (( $+commands[direnv] )); then
  export DIRENV_LOG_FORMAT=""
  eval "$(direnv hook zsh)"
fi

# ---- zsh プラグイン (Homebrew) ----
[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] \
  && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# syntax-highlighting は最後に読み込む
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
  && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- エイリアス ----
alias ls='ls -G'
alias ll='ls -la'
alias la='ls -A'
alias grep='grep --color=auto'
alias p='pnpm'

# git (旧 oh-my-zsh git プラグイン相当の最小セット)
alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# マージ済み (upstream が gone) のローカルブランチを削除
# gbgd = 安全 (-d) / gbgD = 強制 (-D)
gbgd() { git fetch -p && git branch -vv | grep ': gone]' | grep -v '^\*' | awk '{print $1}' | xargs -r git branch -d; }
gbgD() { git fetch -p && git branch -vv | grep ': gone]' | grep -v '^\*' | awk '{print $1}' | xargs -r git branch -D; }
# main/master/現在ブランチ以外のマージ済みブランチを一括削除
gbda() { git branch --merged | grep -vE '^\*|^\+|\s(main|master)$' | xargs -r git branch -d; }

# ---- 履歴設定 ----
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

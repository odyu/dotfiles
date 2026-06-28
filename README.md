# dotfiles

GNU Stow で管理する macOS 開発環境設定。`starship` + `mise` + 素の zsh によるモダン構成（oh-my-zsh / p10k は使わない）。

## 構成

```
.
├── Brewfile                # Homebrew formula / cask / tap / font / vscode
├── Makefile                # 冪等な named targets (セットアップ入口)
├── macos/defaults.sh       # macOS システム既定値 (キーリピート等)
├── zsh/
│   ├── .zshrc              # インタラクティブシェル設定
│   ├── .zshenv             # 環境変数 (秘密なし) + ~/.zshenv.local を読み込み
│   └── .zshenv.local.example
├── git/
│   ├── .gitconfig          # 共有設定 (identity 以外)
│   └── .gitconfig.local.example
├── tmux/.tmux.conf
└── config/.config/
    ├── aerospace/aerospace.toml   # タイル型ウィンドウマネージャ
    ├── starship/starship.toml     # プロンプト (Nord)
    ├── mise/config.toml           # ランタイム (node/ruby/python)
    ├── karabiner/karabiner.json   # キーリマップ
    ├── ghostty/config             # ターミナル
    ├── gh/config.yml              # GitHub CLI
    ├── git/ignore                 # グローバル gitignore
    └── nvim/init.lua
```

## Quick Start (新しい Mac)

```bash
git clone https://github.com/odyu/dotfiles.git ~/dotfiles
cd ~/dotfiles
make all          # Homebrew + Brewfile + stow + mise

# マシン固有設定を作成 (秘密情報・identity は Git 管理外)
cp zsh/.zshenv.local.example   ~/.zshenv.local    # API トークン等を記入
cp git/.gitconfig.local.example ~/.gitconfig.local # 名前/メールを記入

make macos        # キーリピート等の macOS 既定値 (任意)
exec $SHELL -l
```

## Make ターゲット

```bash
make help         # 一覧
make all          # 初回フルセットアップ (bootstrap + brew + link + mise + local)
make bootstrap    # Homebrew 未導入なら導入
make brew         # Brewfile を同期
make link         # stow で symlink (既存実ファイルは ~/dotfiles-backup へ退避)
make sync         # 日常の同期 (brew + link + mise)
make mise         # ランタイムをインストール
make macos        # macOS システム既定値を適用
make check        # 非破壊チェック (zsh -n / stow dry-run / 秘密スキャン)
make unlink       # symlink 解除
```

## 設計方針

- **秘密情報・マシン固有設定は Git 管理外**にする:
  - 環境変数・API トークン・マシン固有 PATH → `~/.zshenv.local`
  - git の identity (name/email) → `~/.gitconfig.local`
  - 業務リポジトリ設定 → `~/.gitconfig-chrogo`（`~/workspace/chrogo/` 配下で自動適用）
- **ランタイムは mise に一本化**（anyenv/nodenv/pyenv/rbenv は使わない）。ruby は `compile=false` でプリビルドを使用しビルドフラグを不要にする。
- **プロンプトは starship**（Nord 配色、複数行、言語バージョン表示）。

## 既存 Mac からの移行メモ

`make link` は既存の実ファイルを `~/dotfiles-backup/` に退避してから symlink を張る。移行後に不要なら以下を撤去:

```bash
rm -rf ~/.oh-my-zsh ~/.p10k.zsh        # oh-my-zsh / powerlevel10k
rm -f  ~/.config/starship.toml          # 旧フラットな starship 設定
# anyenv/nodenv/pyenv/rbenv の残骸 (~/.anyenv 等) も不要なら削除
```

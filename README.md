# dotfiles

GNU Stow で管理する macOS 開発環境設定。

```
.
├── config/
│   └── .config/
│       ├── aerospace/aerospace.toml
│       ├── mise/config.toml
│       ├── nvim/init.lua
│       └── starship/starship.toml
├── git/.gitconfig
├── tmux/.tmux.conf
├── zsh/
│   ├── .zshenv
│   └── .zshrc
└── install.sh
```

## Quick Start

```bash
cd ~/dotfiles
./install.sh
exec $SHELL -l
```

## Stow Packages

```bash
stow zsh     # ~/.zshrc, ~/.zshenv
stow config  # ~/.config/nvim, starship, mise, aerospace
stow tmux    # ~/.tmux.conf
stow git     # ~/.gitconfig
```

## Manual Setup (after install)

```bash
# machine-specific config (secrets, PATH overrides)
touch ~/.zshenv.local

# git identity
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## Caution

`stow -R` overwrites existing files. Backup first if needed.
To adopt existing files into stow, use `stow --adopt`.

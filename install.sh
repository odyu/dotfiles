#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

echo "==> 1. Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew update

echo "==> 2. Installing packages..."
brew install stow mise starship zsh-autosuggestions zsh-syntax-highlighting

echo "==> 3. Stowing dotfiles..."
cd "$DOTFILES"
stow -R zsh
stow -R tmux
stow -R git
stow -R config

echo "==> 4. Installing mise tools..."
if command -v mise &>/dev/null; then
  mise install
fi

echo "==> Done!"
echo ""
echo "Manual steps remaining:"
echo "  1. Create ~/.zshenv.local  (machine-specific PATH, secrets)"
echo "  2. Restart shell: exec \$SHELL -l"
echo "  3. Configure git user: git config --global user.name \"Your Name\""
echo "                         git config --global user.email \"your@email.com\""

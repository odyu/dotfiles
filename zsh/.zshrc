# ---- 環境変数 ----
[[ -f ~/.zshenv ]] && source ~/.zshenv

# ---- Starship ----
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# ---- mise ----
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# ---- 補完プラグイン (Homebrew 経由) ----
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- エイリアス ----
alias ls='ls -G'
alias ll='ls -la'
alias la='ls -A'
alias grep='grep --color=auto'

# ---- 履歴設定 ----
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

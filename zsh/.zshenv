# 環境固有の設定 (PATH, 秘密情報など) — Git管理外
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# Starship: config が .config/starship/starship.toml にある場合の明示指定
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

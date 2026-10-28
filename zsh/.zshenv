# 環境固有の設定 (PATH, 秘密情報など) — Git管理外
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# ---- mise: 親プロセスから持ち越された壊れた状態を毎回リセット ----
# GUI アプリ (Orca 等) が「mise 有効なシェル」の環境を引き継いで起動すると、
# __MISE_ORIG_PATH に mise のパスが混ざったまま固定され、その PATH が
# 全ターミナルに配られる。mise は __MISE_DIFF により「適用済み」と判断して
# 並べ替えをしないため /usr/bin/ruby (2.6.10) が勝ち続ける。
# ここで持ち越しを捨てて、mise 管理パスを素の PATH から入れ直す。
unset __MISE_ORIG_PATH __MISE_DIFF __MISE_SESSION __MISE_ZSH_PRECMD_RUN __MISE_ZSH_CHPWD_RAN

if (( $+commands[mise] )); then
  # 古い mise 管理パス (installs/*/bin, shims) を PATH から除去
  path=(${path:#$HOME/.local/share/mise/installs/*})
  path=(${path:#$HOME/.local/share/mise/shims})
  # 非対話シェルでもバージョンが解決するよう shims を先頭に置く
  # (対話シェルでは .zshrc の mise activate が実体パスをさらに前に置く)
  path=($HOME/.local/share/mise/shims $path)
  export PATH
fi

# Starship: config が .config/starship/starship.toml にある場合の明示指定
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

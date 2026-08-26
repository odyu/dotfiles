# ============================================================
# Brewfile — `brew bundle --file=Brewfile` で一括インストール
# ============================================================

# ---- Taps ----
tap "nikitabobko/tap"      # AeroSpace
tap "felixkratz/formulae"  # JankyBorders (borders)

# ---- シェル / dotfiles 基盤 ----
brew "mas"                      # Mac App Store アプリの CLI 管理
brew "stow"                     # dotfiles の symlink 管理
brew "starship"                 # プロンプト
brew "mise"                     # ランタイムバージョン管理
brew "direnv"                   # ディレクトリ単位の環境変数
brew "zsh-autosuggestions"      # 入力補完
brew "zsh-syntax-highlighting"  # シンタックスハイライト
brew "zsh-completions"          # 追加補完定義
brew "gh"                       # GitHub CLI
brew "borders"                  # AeroSpace のウィンドウ枠
brew "tmux"                     # ターミナルミュレクサ
brew "pnpm"                     # パッケージマネージャ

# ---- ネットワーク / トンネル ----
brew "cloudflared"
brew "tunnelblick"              # OpenVPN クライアント

# ---- 開発言語ツール ----
brew "rust"
brew "php"
brew "openjdk"                  # Java 開発キット
brew "python-setuptools"
brew "node"                     # node / pnpm は mise で管理も併用

# ---- データベース / インフラ ----
brew "mkcert"
brew "foreman"
brew "ollama"
brew "mysql"

# ---- 画像 / メディア / ドキュメント処理 ----
brew "vips"
brew "ffmpeg"
brew "jpeg"
brew "graphviz"
brew "d2"
brew "imagemagick"
brew "imagemagick@6"
brew "tesseract"                # OCR エンジン
brew "tesseract-lang"           # Tesseract 言語パック

# ---- OCR / 形態素解析 ----
brew "mecab"                    # 形態素解析
brew "mecab-ipadic"             # MeCab 辞書

# ---- ライブラリ / その他 ----
brew "libyaml"
brew "libpng"
brew "cairo"
brew "pango"
brew "librsvg"
brew "giflib"
brew "libraw"
brew "pkgconf"
brew "openssl@3"
brew "conda-zsh-completion"
brew "bitwarden-cli"
# ---- AI / LLM ----
# Orca ADE (Agent Development Environment) は Homebrew 未対応
# https://www.onorca.dev/ から手動ダウンロード
brew "opencode"                 # AI コーディングエージェント

# ---- フォント ----
cask "font-jetbrains-mono-nerd-font"
cask "font-hack-nerd-font"

# ---- ウィンドウ / 入力 / ランチャー ----
cask "nikitabobko/tap/aerospace"
cask "karabiner-elements"
cask "google-japanese-ime"
cask "raycast"

# ---- ターミナル / エディタ ----
cask "ghostty"
cask "iterm2"
cask "visual-studio-code"
cask "coteditor"
cask "jetbrains-toolbox"
cask "claude-code"

# ---- ブラウザ ----
cask "google-chrome"
cask "brave-browser"

# ---- 開発 / コンテナ / VPN ----
cask "docker-desktop"
cask "android-platform-tools"
cask "aws-vpn-client"

# ---- AI ツール ----
cask "chatgpt-atlas"            # ChatGPT 公式ブラウザ
cask "lm-studio"                # ローカル LLM 実行環境
cask "openchamber"              # OpenCode AI エージェント UI
cask "paseo"                    # AI コーディングエージェント デーモン
cask "github"                   # GitHub デスクトップクライアント

# ---- ユーティリティ ----
cask "appcleaner"
cask "balenaetcher"
cask "bitwarden"

# ---- Mac App Store ----
mas "Google Photos", id: 962194608

# ---- VS Code 拡張 ----
vscode "anthropic.claude-code"
vscode "continue.continue"
vscode "dbaeumer.vscode-eslint"
vscode "dotenv.dotenvx-vscode"
vscode "ms-azuretools.vscode-containers"
vscode "ms-ceintl.vscode-language-pack-ja"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode.makefile-tools"
vscode "ms-vscode.vscode-typescript-next"
vscode "shuvamraghuvanshi.run-package-scripts"

# ---- npm ----
npm "corepack"

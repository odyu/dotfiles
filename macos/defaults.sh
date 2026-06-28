#!/usr/bin/env bash
# ============================================================
# macOS のシステム既定値 (defaults write)
# 適用: make macos  /  bash macos/defaults.sh
# 反映にはログアウト/再起動、またはアプリ再起動が必要なものがあります
# ============================================================
set -euo pipefail

echo "==> キーリピート (GUI の限界を超えた高速設定)"
# KeyRepeat: リピート間隔。GUI 最速=2、ここでは限界超えの 1
defaults write -g KeyRepeat -int 1
# InitialKeyRepeat: リピート開始までの遅延。GUI 最短=15、ここでは 10
defaults write -g InitialKeyRepeat -int 10
# 長押しでアクセント候補ではなくキーリピートを有効化 (vim 等で便利)
defaults write -g ApplePressAndHoldEnabled -bool false

echo "==> Spotlight (Raycast を使うので無効化)"
sudo mdutil -a -i off 2>/dev/null || true

echo "==> compinit 警告対策 (Homebrew ディレクトリの group-w 除去)"
sudo chmod g-w /opt/homebrew/share 2>/dev/null || true

echo "==> キーボード / 入力"
# フルキーボードアクセス (Tab で全コントロールを移動)
defaults write -g AppleKeyboardUIMode -int 3
# 自動大文字化・スマートクォート等を無効化 (コード入力向け)
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

echo "==> Finder"
# 全拡張子を表示
defaults write -g AppleShowAllExtensions -bool true
# 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool true
# パスバー / ステータスバーを表示
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# .DS_Store をネットワーク/USB に作らない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "==> スクリーンショット"
# 影をつけない
defaults write com.apple.screencapture disable-shadow -bool true

echo "==> 完了。反映のため Finder を再起動します"
killall Finder 2>/dev/null || true

echo ""
echo "※ キーリピート設定はログアウト/再起動後に完全反映されます"

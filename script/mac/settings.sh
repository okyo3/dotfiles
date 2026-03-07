#!/bin/zsh

# display
# スリープさせない
sudo pmset -a disablesleep 1
# パワーナップをオフにする
sudo pmset -a powernap 0
# スクロールバーを常時表示する
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# ディスプレイをオフにしない
defaults write com.apple.preference.battery hasBeenWarnedAboutEnergyUsage -int 1

# trackpad and mouse
# 4本指でwindowを操作
defaults write -g AppleEnableSwipeNavigateWithScrolls -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
# 3本指でドラッグ
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
# タップでクリック
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -bool true
# trackpadの操作速度を速める
defaults write -g com.apple.trackpad.scaling 3
defaults write -g com.apple.trackpad.scrolling -int 1
# マウスの操作速度を速める
defaults write -g com.apple.mouse.scaling 3
defaults write -g com.apple.scrollwheel.scaling -int 1
# キーリピートの高速化
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# 高速化
# ツールチップ表示までのタイムラグをなくす
defaults write -g NSInitialToolTipDelay -integer 0
# スプリングロード遅延を除去する
defaults write NSGlobalDomain com.apple.springing.delay -float 0
# ディレクトリのスプリングロードを有効にする
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
# コンソールアプリケーションの画面サイズ変更を高速にする
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# animation
# ウィンドウを開閉するときのアニメーションを無効
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
# ウィンドウサイズを調整する際の加速再生
defaults write -g NSWindowResizeTime -float 0.001
# 視差効果を減らす
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1
defaults write com.apple.universalaccess reduceMotion -int 1

# keyboard
# capslockをctrlに割り当て
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771300</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771129</integer>\
</dict>
"
# option+tabでwindowの移動をする
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>48</integer><integer>524288</integer></array><key>type</key><string>standard</string></dict></dict>"
# フルキーボードアクセスを有効化
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# 音声入力の無効化
defaults write com.apple.HIToolbox AppleDictationAutoEnable -int 0

# finder
# 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles YES
# 終了する項目を追加
defaults write com.apple.Finder QuitMenuItem -bool true
# フォルダを開くときのアニメーションを無効
defaults write com.apple.finder AnimateWindowZoom -bool false
# Finderのファイルを開く時のアニメーションを停止
defaults write com.apple.finder ZoomRects -bool false
# 拡張子変更時の警告を無効化する
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# ゴミ箱を空にする前の警告を無効化する
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# フルパスを表示
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true 
# アニメーションを無効
defaults write com.apple.finder DisableAllAnimations -bool true
# 開いた時にhomeディレクトリを表示
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
# 拡張子を表示
defaults write -g AppleShowAllExtensions -bool true
# カラム表示
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# 最近使ったタグを非表示
defaults write com.apple.finder ShowRecentTags -bool false
# ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true
# タブバーを表示
defaults write com.apple.finder ShowTabView -bool false
# バスバーを表示
defaults write com.apple.finder ShowPathbar -bool true
# デスクトップに表示/非表示する項目
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
# サイドバーからアクセスするフォルダを表示
defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true
# サイドバーから共有項目を非表示
defaults write com.apple.finder SidebarSharedSectionDisclosedState -bool false
# サイドバーからicloud関連を非表示
defaults write com.apple.finder SidebarShowingiCloudDesktop -bool false
defaults write com.apple.finder SidebariCloudDriveSectionDisclosedState -bool false

# menubar
# 音量アイコンをMenuBarに表示
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Sound -int 18
# ディスプレイアイコンをMenuBarに表示
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Display -int 18
# BluetoothをMenuBarに表示
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18
# 時間は秒数まで表示
defaults write com.apple.menuextra.clock DateFormat -string "M\"\"U6708d\\U65e5(EEE)  H:mm:ss"
defaults write ~/Library/Preferences/com.apple.finder.plist AppleICUTimeFormatStrings -dict-add 1 "hh':'mm':'ss' 'a"
# バッテリーのパーセント表示
# defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true

# dock
# Dock の拡大機能を入にする
defaults write com.apple.dock magnification -bool true
# Dock の拡大サイズを最大にする
defaults write com.apple.dock magnification -bool true
# dockから全てのアプリを非表示
defaults write com.apple.dock persistent-apps -array
# 表示と非表示を自動切り替え
defaults write com.apple.dock autohide -bool true
# Dockからアプリを起動するときのアニメーションを無効
defaults write com.apple.dock launchanim -bool false
# サイズを中ぐらいにする
defaults write com.apple.dock tilesize -int 45
# Dockの位置を左にする
defaults write com.apple.dock orientation -string "left"
# 最近使ったアプリを非表示
defaults write com.apple.dock show-recents -bool false
# dockの表示速度を高速化
defaults write com.apple.dock autohide-time-modifier -int 0
# アプリをしまうときのアニメーション
defaults write com.apple.dock mineffect -string "scale"
# 使用状況に基づいてデスクトップの順番を入れ替え
defaults write com.apple.dock mru-spaces -bool "false"

# other
# ブート時のサウンドの無効化
sudo nvram SystemAudioVolume=" "
# スクリーンショットの影を消す
defaults write com.apple.screencapture disable-shadow -boolean true
# スクリーンショットの保存形式を PNG にする
defaults write com.apple.screencapture type -string "png"
# クラッシュレポートを無効化する
defaults write com.apple.CrashReporter DialogType -string "none"
# フィードバックを送信しない
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"
# USB やネットワークストレージに .DS_Store ファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# 未確認のアプリケーションを実行する際のダイアログを無効にする
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Bluetooth ヘッドフォン・ヘッドセットの音質を向上させる
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
# UTF-8 のみを使用する
defaults write com.apple.terminal StringEncodings -array 4

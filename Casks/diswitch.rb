cask "diswitch" do
  version "0.1.0"
  sha256 "7aee4eb253a8a48a71256280b7f5ccc1a71f5016301e2d5b2e247a16638d265f"

  url "https://github.com/kyungryeol-yoon/DiSwitch/releases/download/v#{version}/DiSwitch-#{version}.zip"
  name "DiSwitch"
  desc "Menu bar app to switch an external monitor's input source over DDC/CI"
  homepage "https://github.com/kyungryeol-yoon/DiSwitch"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "DiSwitch.app"

  # 애플 개발자 서명·공증을 하지 않은 앱이라, 「확인되지 않은 개발자」 경고 없이 열리도록 격리 표시를 지움
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/DiSwitch.app"],
                   sudo: false
  end

  uninstall quit: "app.displayinputswitch"

  zap trash: "~/Library/Preferences/app.displayinputswitch.plist"
end

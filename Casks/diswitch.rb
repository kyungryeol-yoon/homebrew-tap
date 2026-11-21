cask "diswitch" do
  version "0.1.2"
  sha256 "b8d72f1fc592cba77fa2d038546fa8f425528ba8f6f3235aa0359cadb1802bf3"

  url "https://github.com/kyungryeol-yoon/DiSwitch/releases/download/v#{version}/DiSwitch-#{version}.zip"
  name "DiSwitch"
  desc "Menu bar app to switch an external monitor's input source over DDC/CI"
  homepage "https://github.com/kyungryeol-yoon/DiSwitch"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "DiSwitch.app"

  # 애플 개발자 서명·공증을 하지 않은 앱이라, 「확인되지 않은 개발자」 경고 없이 열리도록 격리 표시를 지움
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/DiSwitch.app"],
        writable_paths: ["{{appdir}}/DiSwitch.app"]
  end

  uninstall quit: "io.github.kyungryeol-yoon.diswitch"

  zap trash: [
    "~/Library/Preferences/io.github.kyungryeol-yoon.diswitch.plist",
    "~/Library/Preferences/app.displayinputswitch.plist", # 2026-11-21 이전 번들 ID
  ]
end

cask "diswitch" do
  version "0.1.4"
  sha256 "d1672b726302070f664efea9e7052b208ac46a9e2fa3950829cda4fc0d551de3"

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

  # plist만 휴지통에 버리면 cfprefsd가 메모리에 들고 있던 옛 설정을 다시 설치한 앱이 그대로 읽음 → defaults로 먼저 지움
  zap script: {
        executable:   "/usr/bin/defaults",
        args:         ["delete", "io.github.kyungryeol-yoon.diswitch"],
        must_succeed: false,
      },
      trash:  [
        "~/Library/Preferences/io.github.kyungryeol-yoon.diswitch.plist",
        "~/Library/Preferences/app.displayinputswitch.plist", # 2026-11-21 이전 번들 ID
      ]
end

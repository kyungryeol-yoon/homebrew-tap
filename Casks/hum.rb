cask "hum" do
  version "0.1.1"
  sha256 "354c39ceeb5da228877c6abb7359e78136d740077b84b3db987d535ee92734d1"

  url "https://github.com/kyungryeol-yoon/hum/releases/download/v#{version}/Hum-#{version}.zip"
  name "Hum"
  desc "Menu bar chip icon that shows how busy your Mac is"
  homepage "https://github.com/kyungryeol-yoon/hum"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Hum.app"

  # 애플 개발자 서명·공증을 하지 않은 앱이라, 「확인되지 않은 개발자」 경고 없이 열리도록 격리 표시를 지움
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Hum.app"],
        writable_paths: ["{{appdir}}/Hum.app"]
  end

  uninstall quit: "io.github.kyungryeol-yoon.hum"

  zap trash: "~/Library/Preferences/io.github.kyungryeol-yoon.hum.plist"
end

cask "macinv" do
  version "0.1.1"
  sha256 "fe0828effd34d85197a70f4c724fec0017bf05e69a2ec3fe7acadd35e81df994"

  url "https://github.com/kyungryeol-yoon/MacInv/releases/download/v#{version}/MacInv-#{version}.zip"
  name "MacInv"
  desc "Menu bar app that inventories, updates and safely cleans up what is installed on your Mac"
  homepage "https://github.com/kyungryeol-yoon/MacInv"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "MacInv.app"

  # 애플 개발자 서명·공증을 하지 않은 앱이라, 「확인되지 않은 개발자」 경고 없이 열리도록 격리 표시를 지움
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/MacInv.app"],
        writable_paths: ["{{appdir}}/MacInv.app"]
  end

  # `uninstall quit:`은 넣지 않는다 — MacInv 안에서 자기 업데이트(brew upgrade --cask macinv)를 돌리면
  # brew가 MacInv를 끄면서 진행 화면도 같이 사라진다. 실행 중에 번들을 바꿔도 지금 프로세스는 그대로 돌고,
  # 끝나면 MacInv가 「다시 시작」을 띄운다.

  zap trash: [
    "~/Library/Caches/io.github.kyungryeol-yoon.macinv",
    "~/Library/HTTPStorages/io.github.kyungryeol-yoon.macinv",
    "~/Library/Preferences/io.github.kyungryeol-yoon.macinv.plist",
    "~/Library/Saved Application State/io.github.kyungryeol-yoon.macinv.savedState",
  ]
end

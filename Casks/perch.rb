cask "perch" do
  version "1.1.1"
  sha256 "2e73f2641446207d85b8ecd9a8493da18773a21ddcdb5785a201d2486564e983"

  url "https://github.com/trieuluan/perch-mac/releases/download/v#{version}/Perch.dmg"
  name "Perch"
  desc "Notch hub with music visualizers and hidden menu bar icons"
  homepage "https://github.com/trieuluan/perch-mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :sonoma"

  app "Perch.app"

  # Perch isn't notarized (no paid Apple Developer account yet), so clear the
  # quarantine flag to let it open without a Gatekeeper prompt.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Perch.app"]
  end

  uninstall quit: "com.trieuluan.perch"

  zap trash: [
    "~/Library/Application Scripts/com.trieuluan.perch",
    "~/Library/Containers/com.trieuluan.perch",
  ]
end

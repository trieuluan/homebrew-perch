cask "perch" do
  version "1.2.0"
  sha256 "2cf04170a7d7342f0f24f394019572e8043f9bc6a4d2657c2cc5390291b36e0c"

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

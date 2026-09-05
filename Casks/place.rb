cask "place" do
  # "<marketing>,<build>" — Homebrew's two-part form. `version.csv.first` is
  # 1.0 and `version.csv.second` is the build, which is what actually moves
  # between releases here (marketing has stayed 1.0 since R1).
  version "1.0,8"
  sha256 "0f41fbd3386242d221ebfc0b36acfc42017a2b1420ce126202d8e24461c4138d"

  # GITHUB RELEASES on the TAP REPO ITSELF (2026-08-26). One public repo holds
  # both the casks and the DMG assets: `brew tap` clones only the git tree, and
  # release assets live outside it, so the clone stays tiny however many ~97 MB
  # DMGs hang off it.
  #
  # Chosen over uxlabs.app because a release asset URL is versioned and
  # IMMUTABLE — it cannot be silently overwritten, which is the one failure a
  # sha256-checked cask cannot survive — and uxlabs.app is plain Apache with no
  # CDN, while every install/upgrade pulls the whole file.
  # uxlabs.app/downloads/Place.dmg stays as the website's own stable link.
  #
  # Tags are APP-PREFIXED (`place-v…`) so Spatialize can share this repo's
  # releases later without the two colliding.
  #
  # `verified:` is required because this host differs from `homepage`; it names
  # the prefix Homebrew should trust as belonging to the same project.
  url "https://github.com/UXLabPro/homebrew-tap/releases/download/place-v#{version.csv.first}-#{version.csv.second}/Place-#{version.csv.first}-#{version.csv.second}.dmg",
      verified: "github.com/UXLabPro/homebrew-tap/"
  name "Place"
  desc "Menu bar window manager for snapping windows into screen zones"
  homepage "https://uxlabs.app/place/"

  # The app's own update feed doubles as the livecheck source, so there is one
  # place to bump per release rather than two.
  livecheck do
    url "https://www.uxlabs.app/updates/place.json"
    strategy :json do |json|
      next if json["version"].nil? || json["build"].nil?

      "#{json["version"]},#{json["build"]}"
    end
  end

  auto_updates true
  depends_on macos: :tahoe

  app "Place.app"

  # Menu-bar app: it has no Dock icon to quit from, and it registers a login
  # item on first launch, so both need naming explicitly or `brew uninstall`
  # leaves it running and set to relaunch at login.
  uninstall quit:       "pro.UXLab.Place",
            login_item: "Place"

  # Every path below was observed on a Mac that had actually run Place — the
  # RevenueCat and WebKit ones are not guessable from the bundle id alone.
  zap trash: [
    "~/Library/Application Scripts/pro.UXLab.Place",
    "~/Library/Application Support/pro.UXLab.Place",
    "~/Library/Application Support/pro.UXLab.Place.revenuecat",
    "~/Library/Caches/pro.UXLab.Place",
    "~/Library/Caches/pro.UXLab.Place.revenuecat",
    "~/Library/Containers/pro.UXLab.Place",
    "~/Library/HTTPStorages/pro.UXLab.Place",
    "~/Library/HTTPStorages/pro.UXLab.Place.binarycookies",
    "~/Library/Preferences/pro.UXLab.Place.plist",
    "~/Library/WebKit/pro.UXLab.Place",
  ]

  caveats <<~EOS
    Place needs Accessibility permission to move other apps' windows.
    It asks on first launch, or you can grant it here:

      System Settings → Privacy & Security → Accessibility
  EOS
end

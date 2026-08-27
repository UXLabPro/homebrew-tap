# UXLab Homebrew Tap

Homebrew casks for [UXLab](https://uxlabs.app) Mac apps.

## Install

```sh
brew tap uxlabpro/tap && brew trust uxlabpro/tap && brew install --cask place
```

Homebrew 6 asks you to trust a third-party tap before it will load casks from
it. `brew trust` records that choice on your Mac only; undo it any time with
`brew untrust uxlabpro/tap`.

## Apps

| Cask    | App                                                | Requires        |
| ------- | -------------------------------------------------- | --------------- |
| `place` | [Place](https://uxlabs.app/place/) — menu bar window manager | macOS 26.5 or later |

Place needs Accessibility permission so it can move other apps' windows. It asks
on first launch, or grant it in System Settings ▸ Privacy & Security ▸
Accessibility.

## Updating and removing

```sh
brew upgrade --cask place     # update to the current release
brew uninstall --cask place   # remove the app
brew uninstall --zap --cask place   # remove the app and its settings
```

## Downloads

Every release is published here with its DMG attached, and each DMG is signed
with a Developer ID certificate, notarized by Apple, and stapled. The checksum
in the cask is verified by Homebrew on download; the release notes list it too,
so you can check a manual download with `shasum -a 256`.

Prefer not to use Homebrew? The same builds are at
[uxlabs.app](https://uxlabs.app).

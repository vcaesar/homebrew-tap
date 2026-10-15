# homebrew-tap

Homebrew tap for [vcaesar](https://github.com/vcaesar) apps.

## Setup

```sh
brew tap vcaesar/tap
```

## codg

The next code and work AI agent (CLI). macOS (Intel / Apple Silicon) and Linux (amd64 / arm64).

```sh
brew install vcaesar/tap/codg
codg --version
```

## codg-desktop

The Codg desktop app. macOS (Monterey or later) and Linux (amd64 / arm64).

```sh
brew install --cask vcaesar/tap/codg-desktop
```

On Linux, GTK 3 and WebKitGTK 4.1 are required, e.g. on Debian/Ubuntu:

```sh
sudo apt install libgtk-3-0 libwebkit2gtk-4.1-0
```

The desktop cask can be installed alongside the `codg` formula without conflicts.

## vhand

The AI translate and voice assistant. macOS only.

```sh
brew install --cask vcaesar/tap/vhand
```

## Upgrade / Uninstall

```sh
brew update && brew upgrade codg
brew upgrade --cask codg-desktop vhand

brew uninstall codg
brew uninstall --cask codg-desktop vhand
```

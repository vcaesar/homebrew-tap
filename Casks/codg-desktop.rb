# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
cask "codg-desktop" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.10"
  sha256 arm:          "c5cc2696a53fcb01e409ceff7f7e0a97f4ee9b2a75e7f161adff3a7a675aad84",
         intel:        "cf414b6871690588cc7c670752d4de31bce59f8056265f9c069b7d916fa94fa5",
         arm64_linux:  "4d3d71cd206ebbeec3f5a5d69c64ab526dece24fe195b0c4fab1d2d1f380c578",
         x86_64_linux: "534fb0b7088ca5fc97111620b5066e8c69f996f31429d47a03c599d989e46edb"

  on_macos do
    url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg-desktop-#{os}-#{arch}.dmg"
  end
  on_linux do
    url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg-desktop-#{os}-#{arch}.tar.gz"
  end

  name "Codg"
  desc "The next code and work AI agent desktop app"
  homepage "https://github.com/vcaesar/codg"

  livecheck do
    url :url
    strategy :github_latest
  end

  on_macos do
    depends_on macos: :monterey

    app "Codg.app"
  end

  on_linux do
    preflight_steps do
      inreplace "share/applications/codg-desktop.desktop",
                "Exec=codg-desktop",
                "Exec={{HOMEBREW_PREFIX}}/bin/codg-desktop"
    end

    # The bundled `codg` backend stays next to `codg-desktop` in the Caskroom,
    # so it does not conflict with the `codg` formula.
    binary "codg-desktop"
    artifact "share/applications/codg-desktop.desktop",
             target: "#{Dir.home}/.local/share/applications/codg-desktop.desktop"
    artifact "share/icons/hicolor/1024x1024/apps/codg-desktop.png",
             target: "#{Dir.home}/.local/share/icons/hicolor/1024x1024/apps/codg-desktop.png"

    caveats <<~EOS
      Codg Desktop requires GTK 3 and WebKitGTK 4.1, e.g. on Debian/Ubuntu:
        sudo apt install libgtk-3-0 libwebkit2gtk-4.1-0
    EOS
  end
end

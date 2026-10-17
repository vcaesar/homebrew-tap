# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
cask "codg-desktop" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.5"
  sha256 arm:          "187aa238ce742a9a84c11fdf33227d17f1ead0c45e3e01d22b3a042dac99b07f",
         intel:        "779a198a5835702b03db719020485d974eaadbe3224e43b808faa32a21aa496c",
         arm64_linux:  "9869c49ad4ab9cbef6a2ca9c64225d76388a7dd9bf5f211371e6b20b6f2b26fb",
         x86_64_linux: "adfb1916816165346abeb8e86869382169d87d6b3e20bfac7c2f0bde89c65c38"

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

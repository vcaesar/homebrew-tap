# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
cask "codg-desktop" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.4"
  sha256 arm:          "cb25433b970b459b7753ef519c8bade7a60a59cb93345fa027cdd3b301806e2a",
         intel:        "30cbda5814b7f96b91e552c818f7a57da966d9f3aae8c78add7c116944f2f21c",
         arm64_linux:  "2b60de53cbe815036e284e8e1562b7bbe3a94f0ec49f295a239131a52d6afd04",
         x86_64_linux: "c1be17f971687fb6fb56786776204c1b8993327979d3eac334e97526805addc9"

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

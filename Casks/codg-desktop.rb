# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
cask "codg-desktop" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.7"
  sha256 arm:          "b90f7bbc9c2439bffe76801622aa402d4f391a7f4be923ec00bf4ab8c94766a6",
         intel:        "5ea13b06f9dd0dfaca357b8fe7ea089220a589f833057df8a4566557fe206036",
         arm64_linux:  "d8224e90752495df8d95fd6cedbfd58c90673fc47dcb2e7411bf062047959fac",
         x86_64_linux: "eea32effdaaf584bd6dd2d450d7ac44c9a82bd6d3e85b6773676785496356cce"

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

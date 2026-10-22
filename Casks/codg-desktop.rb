# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
cask "codg-desktop" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.6"
  sha256 arm:          "3a071b0bc18f26de339d48147c651f3b328bb7fd0ed47597b469d3f9fe5c03fd",
         intel:        "a81547dbcdd0f6682a5031b8e21b8c911aed690226fe04a77cbca5c5c805dd89",
         arm64_linux:  "818dc6091d411f35643e6157c9d48c68fceeb234846c0906d388e962e24c581a",
         x86_64_linux: "1196725604f9f534114325eb9ebe0df911228b221e1b0b539aaab691faf4069f"

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

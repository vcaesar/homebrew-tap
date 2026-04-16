# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
cask "vhand" do
  desc "The AI translate and vocie assistant"
  homepage "https://github.com/vcaesar/vhand"
  license "EULA"
  version "v0.10.2"
  arch arm: "arm64", intel: "amd64"
  sha256 arm: "402a5dfddbe338b5afb6e3b1ff3da4c2e14a5470547adc86a04c3ab2910a9297",
        intel: "402a5dfddbe338b5afb6e3b1ff3da4c2e14a5470547adc86a04c3ab2910a9297"
  url "https://github.com/vcaesar/vhand/releases/download/#{version}/Vhand.dmg",
  verified: "github.com/vcaesar/vhand"
  name "Vhand"

  app "Vhand.app"
end
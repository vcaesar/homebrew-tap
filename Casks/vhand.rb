# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
cask "vhand" do
  desc "The AI translate and vocie assistant"
  homepage "https://github.com/vcaesar/vhand"
  version "v0.20.0"
  arch arm: "arm64", intel: "amd64"
  sha256 arm: "d1dadaa7fde6fcf2be09fa3d8d7ddac8a311a1c1f90b563c569326638daaec03",
        intel: "d1dadaa7fde6fcf2be09fa3d8d7ddac8a311a1c1f90b563c569326638daaec03"
  url "https://github.com/vcaesar/vhand/releases/download/#{version}/Vhand.dmg",
  verified: "github.com/vcaesar/vhand"
  name "Vhand"

  app "Vhand.app"
end
# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
class Codg < Formula
  desc "The next code and work AI agent"
  homepage "https://github.com/vcaesar/codg"
  version "2.0.1"
  license "EULA"

  on_macos do
     on_arm do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_arm64.zip"
      sha256 "76b4a83339bead170f619f1b14fd49197e076d15d8ec528c15e767a5b9d0c20c"
    end

    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_amd64.zip"
      sha256 "1d59ac5d1bc94425ddcacbccd6796670ed697f227375f7fef0230bbb5a71c939"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_amd64.zip"
      sha256 "78197afc88941e0dafad602691ac6c6bfee555ca0c317adef7664ec362ee85fd"
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_arm64.zip"
        sha256 "57453ea6367237148a47aebcd56b67f7114f13a17713839ade8f860de7307ea4"
      else
        url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_armv7.zip"
        sha256 "REPLACE_WITH_SHA256_LINUX_ARMV7"
      end
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch =
      if Hardware::CPU.arm?
        Hardware::CPU.is_64_bit? ? "arm64" : "arm"
      else
        "amd64"
      end
    bin.install "codg_#{os}_#{arch}" => "codg"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codg --version")
  end
end
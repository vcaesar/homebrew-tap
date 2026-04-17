# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
class Codg < Formula
  desc "The next code and work AI agent"
  homepage "https://github.com/vcaesar/codg"
  version "2.0.0"
  license "EULA"

  on_macos do
     on_arm do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_arm64.zip"
      sha256 "37ee62ae6ba4e1db6c20bee6de223e36a86edce783f6983e4d5c9ad4bad7eae4"
    end

    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_amd64.zip"
      sha256 "REPLACE_WITH_SHA256_DARWIN_AMD64"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_amd64.zip"
      sha256 "REPLACE_WITH_SHA256_LINUX_AMD64"
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_arm64.zip"
        sha256 "REPLACE_WITH_SHA256_LINUX_ARM64"
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
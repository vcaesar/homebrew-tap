# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
class Codg < Formula
  desc "The next code and work AI agent"
  homepage "https://github.com/vcaesar/codg"
  version "2.4.8"
  license "EULA"

  on_macos do
    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_amd64.zip"
      sha256 "36c038be441627a29ca14655206d1f34659f3f3dfbf62c6c09ed4c4927c4f186"
    end

     on_arm do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_arm64.zip"
      sha256 "0eb277f98646406deef16697fa107017a10762bcb00a7774cc2435981b4706be"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_amd64.zip"
      sha256 "752d0d139423ba9fb1bd76b70c6984b7a869d5017a78aebfa476cbd747da9880"
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_arm64.zip"
        sha256 "99767a7e7801c206fdd5d037e05840b5ea13c5c28e0157424bc0c715fa9be89a"
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
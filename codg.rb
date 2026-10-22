# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
class Codg < Formula
  desc "The next code and work AI agent"
  homepage "https://github.com/vcaesar/codg"
  version "2.6.6"
  license "EULA"

  on_macos do
    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_amd64.zip"
      sha256 "fb41674e271758792d2a0681da030c134646cb89e540a3eb9ceeab3021b5a0f7"
    end

     on_arm do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_arm64.zip"
      sha256 "9aa862907cff7c53c1c157b5f2891194e8b6c7d8f5a629f28baa72bd03dcf0d6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_amd64.zip"
      sha256 "3db0adbd548b82fae9e3a562895f34b13a70c2c68cbafd8b6f358425744fdd9e"
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_arm64.zip"
        sha256 "cb8566745a81ccee5ac4582693f1a8bb9b9ba7089149433178b3ee73c86c7c4c"
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
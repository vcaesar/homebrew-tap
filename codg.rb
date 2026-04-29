# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
class Codg < Formula
  desc "The next code and work AI agent"
  homepage "https://github.com/vcaesar/codg"
  version "2.2.4"
  license "EULA"

  on_macos do
    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_amd64.zip"
      sha256 "b4c631d3bd7eee3919caf79fc28155b23d2c78d26b611de835af2d7adb5e4924"
    end

     on_arm do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_darwin_arm64.zip"
      sha256 "d513f14faefc4f67ceae04d18c0276f3c123802299e471d6893242528afa8ea3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_amd64.zip"
      sha256 "220027e0c820c22b58203527a53786d821cbfe0eb8c6fefb63e8592a2942313f"
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vcaesar/codg/releases/download/v#{version}/codg_linux_arm64.zip"
        sha256 "342404033cd891e0ed2022b49e393b32463a00bdc09818a774300a36c5147032"
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
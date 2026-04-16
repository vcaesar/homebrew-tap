# ("amd64" -> "x86_64", "386" -> "i386", arm -> "armv7").
class Vhand < Formula
  desc "Terminal-based AI coding assistant for developers"
  homepage "https://github.com//vcaesar/vhand"
  version "1.0.1"
  license "EULA"

  on_macos do
     on_arm do
      url "https://github.com//vcaesar/vhand/releases/download/v#{version}/vhand_#{version}_Darwin_arm64.tar.gz"
      sha256 "REPLACE_WITH_SHA256_DARWIN_ARM64"
    end

    on_intel do
      url "https://github.com//vcaesar/vhand/releases/download/v#{version}/vhand_#{version}_Darwin_x86_64.tar.gz"
      sha256 "REPLACE_WITH_SHA256_DARWIN_AMD64"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com//vcaesar/vhand/releases/download/v#{version}/vhand_#{version}_Linux_x86_64.tar.gz"
      sha256 "REPLACE_WITH_SHA256_LINUX_AMD64"
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com//vcaesar/vhand/releases/download/v#{version}/vhand_#{version}_Linux_arm64.tar.gz"
        sha256 "REPLACE_WITH_SHA256_LINUX_ARM64"
      else
        url "https://github.com//vcaesar/vhand/releases/download/v#{version}/vhand_#{version}_Linux_armv7.tar.gz"
        sha256 "REPLACE_WITH_SHA256_LINUX_ARMV7"
      end
    end
  end

  def install
    bin.install "vhand"
    # Man page.
    man1.install "manpages/vhand.1.gz"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vhand --version")
  end
end
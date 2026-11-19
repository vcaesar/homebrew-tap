class Zedsearch < Formula
  desc "Lightweight full-text search engine, an Elasticsearch alternative"
  homepage "https://github.com/vcaesar/zedsearch"
  version "1.3.1"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_darwin_x86_64.tar.gz"
      sha256 "eaeb095ee194465e0897851ad4f964ab4fe905c78db0d5863fa2154901241d82"
    end

    on_arm do
      url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_darwin_arm64.tar.gz"
      sha256 "ec8b861a43346311fca65d1265f0868e9f7443c1e6ca568b875d6e7d80522511"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_linux_x86_64.tar.gz"
      sha256 "ad7bdc795cf7eaf83ddb6480ba95c4ef2ce78631ab25d2d7a28153e63bf9e3ec"
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_linux_arm64.tar.gz"
        sha256 "a02cd9bc9b17e240dbbfc52f961c90ede0a8bddd4e22e0ae83c24b7c71b31cba"
      else
        url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_linux_armv7.tar.gz"
        sha256 "a96c30a14b4308fdb34699d6c369bf870e7db527048f23affa886e04c0b05741"
      end
    end
  end

  def install
    bin.install "zedsearch"
  end

  def caveats
    <<~EOS
      On first start, set the admin credentials:
        ZED_FIRST_ADMIN_USER=admin ZED_FIRST_ADMIN_PASSWORD=<password> zedsearch
    EOS
  end

  test do
    port = free_port
    ENV["ZED_FIRST_ADMIN_USER"] = "admin"
    ENV["ZED_FIRST_ADMIN_PASSWORD"] = "Pass123"
    ENV["ZED_DATA_PATH"] = testpath/"data"
    ENV["ZED_SERVER_PORT"] = port.to_s

    pid = spawn bin/"zedsearch"
    begin
      sleep 5
      assert_match version.to_s, shell_output("curl -s http://127.0.0.1:#{port}/version")
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end

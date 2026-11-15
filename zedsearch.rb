class Zedsearch < Formula
  desc "Lightweight full-text search engine, an Elasticsearch alternative"
  homepage "https://github.com/vcaesar/zedsearch"
  version "1.1.0"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_darwin_x86_64.tar.gz"
      sha256 "bda5cb077961692f162ed3638cb8b5cdda7afc02328e73ba3436c33b28670eab"
    end

    on_arm do
      url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_darwin_arm64.tar.gz"
      sha256 "140b4d966ffc7e44f2000d832ece2d32cd2820ffdd3e5e02165027cb02ee84c1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_linux_x86_64.tar.gz"
      sha256 "ad9a425c0f78b6e38851bfcf68b9f1845f9d5a5f6baa227bf9341bc5a54d2ca6"
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_linux_arm64.tar.gz"
        sha256 "dff80182878c47db8e0ce6555472b0c4164011577f6a46516ecffe26694defea"
      else
        url "https://github.com/vcaesar/zedsearch/releases/download/v#{version}/zedsearch_#{version}_linux_armv7.tar.gz"
        sha256 "9a9050e5a3eba0ca85fd1e1c020a38e85d08f2f992832f120149c9af9aabdeda"
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

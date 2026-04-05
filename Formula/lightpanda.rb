class Lightpanda < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026-04-05"

  livecheck do
    url "https://api.github.com/repos/lightpanda-io/browser/releases/tags/nightly"
    strategy :json do |json|
      json["updated_at"]&.slice(0, 10)
    end
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "8c26aeec76fa0a3d12b3d3c996409f582255d0ef7d77ce377e551b6d9a92f8b0"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "6ffc0e8c965c0da2abcb9d0c425a7f3ef46c9ec083eb5677a147eda8057e966f"
    end
  end

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end

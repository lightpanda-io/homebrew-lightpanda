class Lightpanda < Formula
  desc "Headless browser for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/v0.2.6/lightpanda-aarch64-macos"
      sha256 "e9f76a172fd70108b5b23f12d2a0b42e37c36df6accce5e80fc39585ce3f95c1"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/v0.2.6/lightpanda-x86_64-macos"
      sha256 "36deeff9bdf12709c90c82697422e4fc83f3df7c2d9e47f84b26428446d5bc36"
    end
  end

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lightpanda version 2>&1")
  end
end

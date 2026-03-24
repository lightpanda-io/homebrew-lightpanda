class Lightpanda < Formula
  desc "Headless browser for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  version "0.2.6"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/v#{version}/lightpanda-aarch64-macos"
      sha256 "e9f76a172fd70108b5b23f12d2a0b42e37c36df6accce5e80fc39585ce3f95c1"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/v#{version}/lightpanda-x86_64-macos"
      sha256 "36deeff9bdf12709c90c82697422e4fc83f3df7c2d9e47f84b26428446d5bc36"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/v#{version}/lightpanda-aarch64-linux"
      sha256 "9b77ff3c03181e5038aa44cea78076d038f531624c5949b53a7efd3673c5c0ce"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/v#{version}/lightpanda-x86_64-linux"
      sha256 "f29442646d1c62a4175195b0a149b9e368e2f3487d3a493f96ba0702be8974cc"
    end
  end

  conflicts_with "lightpanda-nightly", because: "both install a lightpanda binary"

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end

class LightpandaNightly < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "nightly-2024-07-16"

  livecheck do
    url "https://api.github.com/repos/lightpanda-io/browser/releases/tags/nightly"
    strategy :json do |json|
      json["published_at"]&.slice(0, 10)&.then { |d| "nightly-#{d}" }
    end
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "32ca6339d0110f81aa051805e7cf4874ebeb0032d62df4abf00e75469f416e71"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "b9cae9277271fd140e52b3a4bfdcc0aa06728ff2309c4673e79a2809158528bb"
    end
  end

  conflicts_with "lightpanda-io/lightpanda/lightpanda", because: "both install a `lightpanda` binary"

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end

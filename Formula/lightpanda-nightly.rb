class LightpandaNightly < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026-03-26"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "d8af7104d05d936bc60196b468a25fae9bc030f089bc12e2b5f25102c6ad4fec"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "7d253cc1d64f93716708886b8ebb50b6036acaefeefe0ef7a19696e57f03b371"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "7b48508cd58c86132052f02c14afc2d10bb1bdb1db6439129574c978ccdad6ac"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "b0cd9cf952d99a6559125a7c632c7f7d0924916f10e3dcfde374b616b762d5b9"
    end
  end

  conflicts_with "lightpanda", because: "both install a lightpanda binary"

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end

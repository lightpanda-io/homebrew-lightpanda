#!/bin/bash
set -euo pipefail

DIR="$(dirname "$0")"
REPO="lightpanda-io/browser"

update() {
  local FORMULA="${DIR}/Formula/lightpanda.rb"

  LATEST=$(curl -sf "https://api.github.com/repos/${REPO}/releases/tags/nightly" \
    | grep '"updated_at"' \
    | head -1 \
    | sed 's/.*"updated_at": *"\([0-9-]*\).*/\1/')
  LATEST="nightly-${LATEST}"
  CURRENT=$(grep '^  version ' "$FORMULA" | sed 's/.*"\(.*\)".*/\1/')

  echo "[nightly] Current: $CURRENT — Latest: $LATEST"

  if [ "$LATEST" = "$CURRENT" ]; then
    echo "[nightly] Already up to date."
    return
  fi

  echo "[nightly] Updating to $LATEST..."
  BASE="https://github.com/${REPO}/releases/download/nightly"

  echo "[nightly] Fetching aarch64 binary..."
  AARCH64_SHA=$(curl -sL "${BASE}/lightpanda-aarch64-macos" | shasum -a 256 | awk '{print $1}')
  echo "[nightly] Fetching x86_64 binary..."
  X86_SHA=$(curl -sL "${BASE}/lightpanda-x86_64-macos" | shasum -a 256 | awk '{print $1}')

  OLD_AARCH64_SHA=$(grep -A1 'aarch64-macos"' "$FORMULA" | grep sha256 | sed 's/.*sha256 "\([^"]*\)".*/\1/')
  OLD_X86_SHA=$(grep -A1 'x86_64-macos"' "$FORMULA" | grep sha256 | sed 's/.*sha256 "\([^"]*\)".*/\1/')

  sed -i '' "s|version \"${CURRENT}\"|version \"${LATEST}\"|" "$FORMULA"
  sed -i '' "s|${OLD_AARCH64_SHA}|${AARCH64_SHA}|" "$FORMULA"
  sed -i '' "s|${OLD_X86_SHA}|${X86_SHA}|" "$FORMULA"

  echo "[nightly] Done. Review changes with: git diff"
}

update

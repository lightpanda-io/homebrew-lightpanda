#!/bin/bash
set -euo pipefail

DIR="$(dirname "$0")"
REPO="lightpanda-io/browser"

update() {
  local FORMULA="${DIR}/Formula/lightpanda.rb"

  RELEASE=$(curl -sf "https://api.github.com/repos/${REPO}/releases/tags/nightly")

  AARCH64_SHA=$(echo "$RELEASE" | jq -r '.assets[] | select(.name == "lightpanda-aarch64-macos") | .digest | sub("^sha256:"; "")')
  X86_SHA=$(echo "$RELEASE" | jq -r '.assets[] | select(.name == "lightpanda-x86_64-macos") | .digest | sub("^sha256:"; "")')

  OLD_AARCH64_SHA=$(grep -A1 'aarch64-macos"' "$FORMULA" | grep sha256 | sed 's/.*sha256 "\([^"]*\)".*/\1/')
  OLD_X86_SHA=$(grep -A1 'x86_64-macos"' "$FORMULA" | grep sha256 | sed 's/.*sha256 "\([^"]*\)".*/\1/')

  CURRENT=$(grep '^  version ' "$FORMULA" | sed 's/.*"\(.*\)".*/\1/')
  LATEST=$(echo "$RELEASE" | jq -r '.updated_at' | sed 's/-/./g; s/T/./; s/://g; s/Z$//')

  echo "[nightly] Current: $CURRENT — Latest: $LATEST"
  echo "[nightly] Current aarch64: $OLD_AARCH64_SHA — Latest: $AARCH64_SHA"
  echo "[nightly] Current x86_64:  $OLD_X86_SHA — Latest: $X86_SHA"

  if [ "$AARCH64_SHA" = "$OLD_AARCH64_SHA" ] && [ "$X86_SHA" = "$OLD_X86_SHA" ]; then
    echo "[nightly] Already up to date."
    return
  fi

  echo "[nightly] Updating from $CURRENT to $LATEST..."

  sed -i "s|version \"${CURRENT}\"|version \"${LATEST}\"|" "$FORMULA"
  sed -i "s|${OLD_AARCH64_SHA}|${AARCH64_SHA}|" "$FORMULA"
  sed -i "s|${OLD_X86_SHA}|${X86_SHA}|" "$FORMULA"

  echo "[nightly] Done. Review changes with: git diff"
}

update

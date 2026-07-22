#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TARGET="$ROOT/vendor/understand-anything"
UA_REPO="https://github.com/Egonex-AI/Understand-Anything.git"
UA_COMMIT="6ae71878beb50226a1e4b7e2f52ac6468c86f74b"

command -v git >/dev/null || { echo 'ERROR: git is required.'; exit 2; }

if [ -d "$TARGET/.git" ]; then
  CURRENT="$(git -C "$TARGET" rev-parse HEAD 2>/dev/null || true)"
  if [ "$CURRENT" = "$UA_COMMIT" ]; then
    echo "UA_SOURCE_READY $CURRENT"
    exit 0
  fi
  echo "[ua] Replacing checkout at $CURRENT with pinned $UA_COMMIT"
  rm -rf "$TARGET"
elif [ -e "$TARGET" ]; then
  echo "[ua] Removing incomplete runtime at $TARGET"
  rm -rf "$TARGET"
fi

mkdir -p "$(dirname "$TARGET")"
git clone --filter=blob:none --no-checkout "$UA_REPO" "$TARGET"
git -C "$TARGET" fetch --depth 1 origin "$UA_COMMIT"
git -C "$TARGET" checkout --detach "$UA_COMMIT"

"$ROOT/scripts/prune-ua-assets.sh"
echo "UA_SOURCE_READY $UA_COMMIT"

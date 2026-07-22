#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TARGET="$ROOT/vendor/understand-anything"
UA_REPO="https://github.com/Egonex-AI/Understand-Anything.git"
UA_COMMIT="6ae71878beb50226a1e4b7e2f52ac6468c86f74b"
DASHBOARD="$TARGET/understand-anything-plugin/packages/dashboard"

command -v git >/dev/null || { echo 'ERROR: git is required.'; exit 2; }

CURRENT=""
if [ -d "$TARGET/.git" ]; then
  CURRENT="$(git -C "$TARGET" rev-parse HEAD 2>/dev/null || true)"
fi

if [ "$CURRENT" != "$UA_COMMIT" ]; then
  if [ -e "$TARGET" ]; then
    echo "[ua] Replacing checkout at ${CURRENT:-unknown} with pinned $UA_COMMIT"
    rm -rf "$TARGET"
  fi
  mkdir -p "$(dirname "$TARGET")"
  git clone --filter=blob:none --no-checkout "$UA_REPO" "$TARGET"
  git -C "$TARGET" fetch --depth 1 origin "$UA_COMMIT"
  git -C "$TARGET" checkout --detach "$UA_COMMIT"
else
  echo "UA_SOURCE_READY $CURRENT"
fi

"$ROOT/scripts/prune-ua-assets.sh"
mkdir -p "$DASHBOARD"
cp "$ROOT/config/vite.config.project.ts" "$DASHBOARD/vite.config.project.ts"
echo "UA_SOURCE_READY $UA_COMMIT"

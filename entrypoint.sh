#!/usr/bin/env bash
set -euo pipefail

# XDG runtime (some stacks whine if it’s missing)
mkdir -p /tmp/runtime-dir
chmod 700 /tmp/runtime-dir
export XDG_RUNTIME_DIR=/tmp/runtime-dir

# Start virtual X
Xvfb :99 -ac -screen 0 1024x768x24 &
sleep 1

# Make DISPLAY visible to subsequent GHA steps too
if [ -n "${GITHUB_ENV:-}" ]; then
  echo "DISPLAY=${DISPLAY}" >> "$GITHUB_ENV"
fi

exec "$@"
#!/usr/bin/env bash
set -euo pipefail

# XDG runtime (some stacks whine if it’s missing)
mkdir -p /tmp/runtime-dir
chmod 700 /tmp/runtime-dir
export XDG_RUNTIME_DIR=/tmp/runtime-dir

exec "$@"
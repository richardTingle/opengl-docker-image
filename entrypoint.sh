#!/bin/bash

# Create and set XDG_RUNTIME_DIR
XDG_RUNTIME_DIR=/tmp/runtime-dir
export XDG_RUNTIME_DIR

mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

echo "export XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" > /etc/profile.d/xdg_runtime_dir.sh
chmod +x /etc/profile.d/xdg_runtime_dir.sh

if [ -n "$GITHUB_ENV" ]; then
  echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" >> "$GITHUB_ENV"
fi

# Execute the command passed to docker run
exec "$@"

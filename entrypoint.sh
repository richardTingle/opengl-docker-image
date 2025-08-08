#!/bin/bash

# Create and set XDG_RUNTIME_DIR
mkdir -p /tmp/runtime-dir
chmod 700 /tmp/runtime-dir
export XDG_RUNTIME_DIR=/tmp/runtime-dir

# Start Xvfb
Xvfb :99 -ac -screen 0 1024x768x16 &

# Export DISPLAY environment variable
export DISPLAY=:99

# Execute the command passed to docker run
exec "$@"
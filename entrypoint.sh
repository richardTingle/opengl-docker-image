#!/bin/bash

# Create and set XDG_RUNTIME_DIR
mkdir -p /tmp/runtime-dir
chmod 700 /tmp/runtime-dir
export XDG_RUNTIME_DIR=/tmp/runtime-dir

# Execute the command passed to docker run
exec "$@"

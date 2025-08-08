#!/bin/bash

# Create and set XDG_RUNTIME_DIR
mkdir -p /tmp/runtime-dir
chmod 700 /tmp/runtime-dir
export XDG_RUNTIME_DIR=/tmp/runtime-dir

# Start Xvfb
Xvfb :99 -ac -screen 0 1024x768x16 &
XVFB_PID=$!

# Export DISPLAY environment variable
export DISPLAY=:99

# Set environment variables for Mesa3D
export LIBGL_ALWAYS_SOFTWARE=1
export MESA_LOADER_DRIVER_OVERRIDE=llvmpipe

# Wait for Xvfb to be ready
echo "Waiting for Xvfb to start..."
max_attempts=30
attempt=0
while ! xdpyinfo -display :99 >/dev/null 2>&1; do
    attempt=$((attempt+1))
    if [ $attempt -ge $max_attempts ]; then
        echo "Xvfb failed to start after $max_attempts attempts"
        exit 1
    fi
    echo "Waiting for Xvfb to start (attempt $attempt/$max_attempts)..."
    sleep 0.5
done
echo "Xvfb started successfully"

# Execute the command passed to docker run
exec "$@"

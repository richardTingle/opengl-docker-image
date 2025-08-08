#!/bin/bash

# Start Xvfb
Xvfb :99 -ac -screen 0 1024x768x16 &

# Export DISPLAY environment variable
export DISPLAY=:99

# Execute the command passed to docker run
exec "$@"
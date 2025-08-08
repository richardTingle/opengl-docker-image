# OpenGL Docker Image

A Docker container for OpenGL-based testing that performs CPU-side rendering for visual unit tests.

## Contents

This Docker image is based on Ubuntu 22.04 and includes:

- OpenJDK 17
- Mesa utilities and libraries for OpenGL rendering
- Xvfb (X Virtual Framebuffer) for headless rendering
- X11 utilities for display management
- Configuration for software rendering via environment variables

## Usage

### Pull the image

```bash
docker pull ghcr.io/OWNER/opengl-docker-image:latest
```

Replace `OWNER` with your GitHub username or organization.

### Run the container

```bash
docker run -it --rm ghcr.io/OWNER/opengl-docker-image:latest
```

### Using in your tests

This image provides the necessary environment for running OpenGL-based tests without a physical display. The environment variables are pre-configured for software rendering:

- `LIBGL_ALWAYS_SOFTWARE=1`
- `MESA_LOADER_DRIVER_OVERRIDE=llvmpipe`
- `DISPLAY=:99`
- `XDG_RUNTIME_DIR=/tmp/runtime-dir`

#### Xvfb Initialization

In your github step you should boot up xvfb. Use a step like this

    - name: Start xvfb
      run: |
        Xvfb :99 -ac -screen 0 1024x768x16 &
        export DISPLAY=:99
        echo "DISPLAY=:99" >> $GITHUB_ENV

## Building Locally

To build the image locally:

```bash
docker build -t opengl-docker-image .
```

## GitHub Actions Workflow

This repository includes a GitHub Actions workflow that automatically builds and publishes the Docker image to GitHub Container Registry.

### Required GitHub Secrets

The workflow uses the following GitHub secrets:

- `GITHUB_TOKEN` - Automatically provided by GitHub Actions, used for authentication with GitHub Container Registry

### Triggering the Workflow

The workflow is triggered on:
- Pushes to the `main` branch
- Tag pushes with the pattern `v*` (e.g., v1.0.0)
- Pull requests to the `main` branch

Images are only pushed to the registry on pushes to the main branch or on tag pushes, not on pull requests.

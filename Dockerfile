# Newer Mesa without PPAs. 24.04 has Mesa 24.x, solid for Zink/lavapipe.
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    mesa-utils \
    mesa-vulkan-drivers \
    vulkan-tools \
    libvulkan1 \
    libgl1 \
    libglx-mesa0 \
    libegl1 \
    xvfb x11-apps \
    ca-certificates curl unzip git \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Force software via Zink (GL over Vulkan) on lavapipe (Vulkan software).
# This path tends to support float color buffers + readPixels more reliably.
ENV LIBGL_ALWAYS_SOFTWARE=1 \
    MESA_LOADER_DRIVER_OVERRIDE=zink \
    GALLIUM_DRIVER=zink \
    VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/lvp_icd.x86_64.json \
    DISPLAY=:99 \
    XDG_RUNTIME_DIR=/tmp/runtime-dir \
    # Advertise a modern GL—Zink can do up to 4.6 on lavapipe:
    MESA_GL_VERSION_OVERRIDE=4.6 \
    MESA_GLSL_VERSION_OVERRIDE=460

# Optional: make headless EGL more reliable if your stack ever uses EGL
ENV __EGL_VENDOR_LIBRARY_DIRS=/usr/share/glvnd/egl_vendor.d

# Simple entrypoint that starts Xvfb and exports DISPLAY for step-local *and* GHA env
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
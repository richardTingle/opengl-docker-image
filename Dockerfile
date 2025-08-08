FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Add PPA for better Mesa drivers
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:kisak/kisak-mesa -y

RUN apt-get update && \
    apt-get install -y \
      openjdk-17-jdk \
      mesa-utils \
      libgl1-mesa-dri \
      libgl1 \
      libglx-mesa0 \
      xvfb \
      x11-utils \
      libopengl0 \
      libgles2-mesa-dev \
      wget unzip && \
    apt-get clean

# Set environment variables for better OpenGL support
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV MESA_LOADER_DRIVER_OVERRIDE=llvmpipe
ENV DISPLAY=:99
ENV XDG_RUNTIME_DIR=/tmp/runtime-dir
# Add this to enable floating point texture support
ENV MESA_GL_VERSION_OVERRIDE=3.3
ENV MESA_GLSL_VERSION_OVERRIDE=330

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
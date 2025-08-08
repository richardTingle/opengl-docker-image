FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
      openjdk-17-jdk \
      mesa-utils \
      libgl1-mesa-dri \
      libgl1 \
      libglx-mesa0 \
      xvfb \
      wget unzip && \
    apt-get clean

ENV LIBGL_ALWAYS_SOFTWARE=1
ENV MESA_LOADER_DRIVER_OVERRIDE=llvmpipe
ENV DISPLAY=:99

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set entrypoint to start Xvfb automatically
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

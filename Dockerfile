FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
      openjdk-17-jdk \
      mesa-utils=8.4.0-1build1 \
      libgl1-mesa-dri=22.0.5-0ubuntu0.1~22.04.3 \
      libgl1=1.4.0-1 \
      libglx-mesa0=22.0.5-0ubuntu0.1~22.04.3 \
      xvfb=2:1.20.13-1ubuntu1.4 \
      wget unzip && \
    apt-get clean

ENV LIBGL_ALWAYS_SOFTWARE=1
ENV MESA_LOADER_DRIVER_OVERRIDE=llvmpipe
ENV DISPLAY=:99

CMD ["bash"]
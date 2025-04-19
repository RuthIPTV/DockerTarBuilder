FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 安装编译依赖
RUN apt update && apt install -y \
  autoconf automake build-essential cmake git libass-dev libfreetype6-dev \
  libgnutls28-dev libtool libvorbis-dev libxcb1-dev libxcb-shm0-dev \
  libxcb-xfixes0-dev meson ninja-build pkg-config texinfo wget yasm \
  zlib1g-dev libvpx-dev libx264-dev libx265-dev libnuma-dev \
  libdrm-dev libva-dev libvdpau-dev libxcb-dri3-0 \
  intel-media-va-driver-non-free vainfo \
  libomxil-bellagio-dev \
  libopus-dev libmp3lame-dev libxvidcore-dev libv4l-dev libpulse-dev \
  && apt clean

# 下载并编译 FFmpeg 最新版
WORKDIR /opt
RUN git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg && \
    cd ffmpeg && \
    ./configure \
      --enable-gpl \
      --enable-libx264 \
      --enable-libx265 \
      --enable-libvpx \
      --enable-libmp3lame \
      --enable-libopus \
      --enable-vaapi \
      --enable-libass \
      --enable-libfreetype \
      --enable-nonfree \
      --enable-libv4l2 \
      --enable-libpulse \
      --enable-libxvid \
      --enable-omx \
      --enable-shared \
      --disable-debug \
    && make -j$(nproc) && make install

ENV LD_LIBRARY_PATH=/usr/local/lib

CMD ["ffmpeg", "-hwaccels"]

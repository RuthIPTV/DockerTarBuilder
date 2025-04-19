FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖库
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    build-essential \
    cmake \
    git \
    libass-dev \
    libfreetype6-dev \
    libsdl2-dev \
    libtool \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb1-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    pkg-config \
    texinfo \
    wget \
    yasm \
    nasm \
    zlib1g-dev \
    libx264-dev \
    libx265-dev \
    libnuma-dev \
    libvpx-dev \
    libmp3lame-dev \
    libopus-dev \
    libpulse-dev \
    libxvidcore-dev \
    libomxil-bellagio-dev \
    libv4l-dev \
    && rm -rf /var/lib/apt/lists/*

# 编译并安装 FFmpeg
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
        --enable-libpulse \
        --enable-libxvid \
        --enable-omx \
        --enable-shared \
        --disable-debug \
        --enable-libv4l2 \
    && make -j$(nproc) && make install && ldconfig

FROM ubuntu:18.04 AS builder
ARG TAG=8.9.255.24
COPY .git /work/.git
COPY .gitmodules /work/.gitmodules
WORKDIR /work
ENV PATH="/work/depot_tools:$PATH" DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
  apt-get install -y git build-essential curl tzdata vim \
    python-minimal python-pip lsb-release g++-aarch64-linux-gnu sudo && \
  update-alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
  fetch --no-history v8 && \
  cd v8 && git fetch --all && git checkout $TAG && \
  gclient sync && \
  ./build/install-build-deps.sh
COPY src /work/src
RUN bash /work/src/build_all_targets.sh

FROM ubuntu:18.04 AS builder
COPY v8 /work/v8
WORKDIR /work
ENV PATH="/work/depot_tools:$PATH" DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
  apt-get install -y git build-essential curl tzdata vim \
    python-minimal python-pip lsb-release sudo && \
  update-alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
  cd v8 && \
  fetch v8 && \
  gclient sync && \
  cd v8 && \
  ./build/install-build-deps.sh && \
  tools/dev/v8gen.py x64.release && \
  mkdir -p out/x64.release && \
  echo "is_clang = false" > out/x64.release/args.gn && \
  echo "target_cpu = \"x64\"" >> out/x64.release/args.gn && \
  echo "is_debug = false" >> out/x64.release/args.gn && \
  echo "v8_monolithic = true" >> out/x64.release/args.gn && \
  echo "v8_use_external_startup_data = false" >> out/x64.release/args.gn && \
  echo "use_custom_libcxx = false" >> out/x64.release/args.gn && \
  echo "use_custom_libcxx_for_host = false" >> out/x64.release/args.gn && \
  echo "v8_static_library = true" >> out/x64.release/args.gn && \
  echo "use_sysroot = false" >> out/x64.release/args.gn && \
  echo "use_glib = false"  >> out/x64.release/args.gn && \
  gn gen out/x64.release && \
  ninja -C out/x64.release v8_monolith

FROM ubuntu:18.04
COPY --from=builder /work/v8/v8/out/x64.release/obj/libv8_monolith.a /usr/local/lib/
COPY --from=builder /work/v8/include /usr/local/include/v8
ENV PATH="/work/depot_tools:$PATH" DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
  apt-get install -y git build-essential curl tzdata vim
FROM gstreamer-builder:latest as builder
FROM ubuntu:latest as final

# Install packages with the required runtime libraries.
RUN apt update && DEBIAN_FRONTEND="noninteractive" apt install -y \
  build-essential cmake libglib2.0-dev libevent-dev \
  libsoup2.4-1 libvpx-dev libgupnp-igd-1.0-4 libsrtp2-dev \
  avahi-utils \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/include/gstreamer-1.0 /usr/include
COPY --from=builder /usr/local/lib/x86_64-linux-gnu/libgstreamer-full-1.0.so /usr/lib/

WORKDIR /src/gstreamer-webrtc-echo
COPY ./data data
COPY ["cJSON.c", "cJSON.h", "CMakeLists.txt", "gstreamer-webrtc-echo.c", "./"]
WORKDIR /src/gstreamer-webrtc-echo/builddir
RUN cmake .. && make 

EXPOSE 8080
ENTRYPOINT ["./gstreamer-webrtc-echo"]
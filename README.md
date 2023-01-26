# webrtc-gst-demo
Demonstrates simple webrtc call with gstreamer



# Building docker 
Build the base docker image 
```
docker buildx build -t gstreamer-builder:latest -f Dockerfile.base  .
```

Build the app docker 
```
docker buildx build -t webrtc-gst-demo:latest .
```

# Run docker 
```
docker run --rm --name webrtc.docker -e "GST_DEBUG=4,dtls*:7" \
-v /var/run/dbus:/var/run/dbus \
-v /var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket \
--network=host  \
webrtc-gst-demo:latest
```
## dev docker 

```
docker run --rm -it --name webrtc.docker -e "GST_DEBUG=4,dtls*:7" \
-v /var/run/dbus:/var/run/dbus \
-v /var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket \
-v /home/muzammil/repos/webrtc-gst-demo:/dev/src \
--workdir /dev/src \
--entrypoint bash \
--network=host  \
webrtc-gst-demo:latest 

```


## Setup rtmp streaming
```
docker network create webrtc-demo # make new network
docker run -d --name=rtmp.docker --network=webrtc-demo -p 1935:1935  alfg/nginx-rtmp
```

## Start sample rtmp stream
```
gst-launch-1.0 -v videotestsrc  is-live=true ! \
    queue ! x264enc ! flvmux ! rtmpsink location='rtmp://localhost:1935/stream/sample1 live=1'
```

Test that sample stream started successfully
```
ffplay rtmp://localhost:1935/stream/sample1

gst-launch-1.0 rtmpsrc location=rtmp://localhost:1935/stream/sample1 ! decodebin ! autovideosink

```


## Start gstreamer app
We start the gstreamer application.

```
STREAM_TYPE=1

docker run --rm --name webrtc.docker \
-v /var/run/dbus:/var/run/dbus \
-v /var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket \
--network=host  \
webrtc-gst-demo:latest ${STREAM_TYPE}
```
Note, you can update the stream type to get rtmp or mp4 video. 

## View stream in browser
- serve index.html using any server e.g. vscode dev server
- open localhost:5500 (or what ever port is assinged by dev server)
- click on `start` button
- wait for 1 minute. the stream takes some time to start
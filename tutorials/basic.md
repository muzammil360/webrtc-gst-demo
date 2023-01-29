

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



## View stream in browser
- run local
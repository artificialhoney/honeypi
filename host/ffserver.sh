#!/bin/bash

sudo apt install ffmpeg

sudo mkdir -p /etc/ffmpeg/

sudo sh -c 'echo "HTTPPort 8090
HTTPBindAddress 0.0.0.0
MaxClients 10
MaxBandwidth 50000
NoDaemon

<Feed webcam.ffm>
file /tmp/webcam.ffm
FileMaxSize 10M
</Feed>

<Stream webcam.mjpeg>
Feed webcam.ffm
Format mjpeg
VideoSize 320x240
VideoFrameRate 10
VideoBitRate 20000
VideoQMin 1
VideoQMax 10
</Stream>

<Stream stat.html>
Format status
</Stream>
" > /etc/ffmpeg/ffserver.conf'

sudo sh -c 'echo "[Unit]
Wants=network.target

[Service]
ExecStart=ffserver -f /etc/ffmpeg/ffserver.conf & ffmpeg -v quiet -r 20 -s 1920x1080 -f video4linux2 -i /dev/video0 http://localhost:8090/webcam.ffm

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/ffserver.service'

sudo systemctl daemon-reload
sudo systemctl enable ffserver
sudo systemctl start ffserver

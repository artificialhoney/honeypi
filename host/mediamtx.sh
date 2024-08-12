#!/bin/bash

mkdir -p ./tmp

sudo apt install libfreetype6 libcamera0

wget -q -O ./tmp/mediamtx.tar.gz - https://github.com/bluenviron/mediamtx/releases/download/v1.8.5/mediamtx_v1.8.5_linux_armv6.tar.gz
tar xzf ./tmp/mediamtx.tar.gz -C ./tmp

mkdir -p /opt/mediamtx
sudo cp ./tmp/mediamtx /opt/mediamtx

sudo ln -s $HONEYPI_MEDIAMTX_CONFIG/mediamtx.yml /opt/mediamtx/mediamtx.yml

sudo sh -c 'echo "[Unit]
Wants=network.target

[Service]
ExecStart=/opt/mediamtx/mediamtx /opt/mediamtx/mediamtx.yml

[Install]
WantedBy=multi-user.target
EOT
" > /etc/systemd/system/mediamtx.service'

sudo systemctl daemon-reload
sudo systemctl enable mediamtx
sudo systemctl start mediamtx

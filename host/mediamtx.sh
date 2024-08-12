#!/bin/bash

sudo apt install libfreetype6 libcamera0

wget -q -O $HOME/mediamtx.tar.gz - https://github.com/bluenviron/mediamtx/releases/download/v1.8.5/mediamtx_v1.8.5_linux_armv6.tar.gz
tar xzf $HOME/mediamtx.tar.gz
rm $HOME/mediamtx.tar.gz

sudo cp -r $HOME/mediamtx /opt

sudo ln -s $HONEYPI_MEDIAMTX_CONFIG/mediamtx.yml /opt/mediamtx/mediamtx.yml

sudo cat << EOT >> /etc/systemd/system/mediamtx.service
[Unit]
Wants=network.target

[Service]
ExecStart=/opt/mediamtx/mediamtx /opt/mediamtx/mediamtx.yml

[Install]
WantedBy=multi-user.target
EOT

sudo systemctl daemon-reload
sudo systemctl enable mediamtx
sudo systemctl start mediamtx

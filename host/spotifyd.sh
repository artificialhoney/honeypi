#!/bin/bash

wget -q -O ./tmp/spotifyd.tar.gz - https://github.com/Spotifyd/spotifyd/releases/download/v0.3.5/spotifyd-linux-armhf-default.tar.gz
tar xzf ./tmp/spotifyd.tar.gz -C ./tmp

sudo mkdir -p /opt/spotifyd
sudo cp ./tmp/spotifyd /opt/spotifyd/

sudo sh -c 'echo "[Unit]
Description=A spotify playing daemon
Documentation=https://github.com/Spotifyd/spotifyd
Wants=sound.target
After=sound.target
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/opt/spotifyd/spotifyd --no-daemon
Restart=always
RestartSec=12

[Install]
WantedBy=default.target
" > /etc/systemd/user/spotifyd.service'

# mkdir -p ~/.config/systemd/user/
# nano ~/.config/systemd/user/spotifyd.service
# sudo systemctl --user daemon-reload

sudo systemctl --user start spotifyd.service

sudo loginctl enable-linger pi
sudo systemctl --user enable spotifyd.service
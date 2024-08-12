#!/bin/bash

wget https://github.com/Spotifyd/spotifyd/releases/latest/spotifyd-linux-armhf-full.tar.gz

sudo sh -c 'echo "[Unit]
Description=A spotify playing daemon
Documentation=https://github.com/Spotifyd/spotifyd
Wants=sound.target
After=sound.target
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/usr/bin/spotifyd --no-daemon
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
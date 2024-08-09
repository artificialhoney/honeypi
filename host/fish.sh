#!/bin/bash

sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish

echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
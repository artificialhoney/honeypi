#!/bin/bash

sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish

echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish

# Does not work
# curl -sL https://git.io/fisher | /usr/bin/fish
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish -o ~/fisher.fish
# /usr/bin/fish ~/fisher.fish && fisher install jorgebucaran/fisher jorgebucaran/nvm.fish
#!/bin/bash

sudo apt-get install build-essential software-properties-common curl jq -y

# git
sudo apt-get install git -y
git config --global user.name "$HONEYPI_GIT_USERNAME"
git config --global user.email "$HONEYPI_GIT_EMAIL"

# home
cd $HOME
git init .
git remote add origin "$HONEYPI_GIT_HOME_URL"
git fetch --all
git reset --hard origin/main
cd - 

# nodejs
curl -O https://unofficial-builds.nodejs.org/download/release/v${HONEYPI_NODE_VERSION}/node-v${HONEYPI_NODE_VERSION}-linux-armv6l.tar.xz
tar -xf node-v${HONEYPI_NODE_VERSION}-linux-armv6l.tar.xz

# docker
curl -fsSL https://get.Docker.com -o get-Docker.sh
sudo sh get-Docker.sh
sudo usermod -aG docker $USER
newgrp docker

# smb
sudo apt-get install samba samba-common-bin -y
sudo sh -c 'echo "
[stuff]
path = /home/'$USER'
writeable = yes
browseable = yes
public=no
" > /etc/samba/smb.conf'
sudo smbpasswd -a $USER
sudo systemctl restart smbd

# ufw
sudo apt-get install ufw -y
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
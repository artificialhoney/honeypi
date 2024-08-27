#!/bin/bash

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
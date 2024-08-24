#!/bin/bash

HONEYPI_SMB_USERNAME=pi

sudo apt install samba samba-common-bin -y

sudo sh -c 'echo "
[stuff]
path = /media/hive/home/'$HONEYPI_SMB_USERNAME'
writeable = yes
browseable = yes
public=no
" > /etc/samba/smb.conf'


sudo smbpasswd -a $HONEYPI_SMB_USERNAME

sudo systemctl restart smbd
#!/bin/bash

sudo -s, apt install samba -y
mv /etc/samba/smb.conf /etc/samba/smb.conf.org
grep -Ev '^#|^;|^$' /etc/samba/smb.conf.org > /etc/samba/smb.conf
exit

sudo smbpasswd -a pi
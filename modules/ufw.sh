#!/bin/bash

sudo apt-get install ufw -y
sudo ufw allow from ${HONEYPI_SUBNET:-'192.168.178.0'}/24
sudo ufw allow 80
sudo ufw allow 443

sudo ufw enable
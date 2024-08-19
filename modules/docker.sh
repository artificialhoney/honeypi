#!/bin/bash

curl -fsSL https://get.Docker.com -o get-Docker.sh
sudo sh get-Docker.sh
sudo usermod -aG docker $USER
newgrp docker

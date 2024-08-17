#!/bin/bash

# portainer
curl -fsSL https://get.Docker.com -o get-Docker.sh
sudo sh get-Docker.sh
sudo usermod -aG docker $USER
newgrp docker
# docker swarm init --advertise-addr eth0
# docker service create --name registry --publish published=5000,target=5000 registry:2

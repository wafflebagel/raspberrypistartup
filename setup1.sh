#!/bin/bash

#UPDATES TO NEWEST RASPBIAN FIRMWARE
sudo apt update
yes | sudo apt full-upgrade

#INSTALL GIT, PYTHON3
yes | sudo apt install git
yes | sudo apt-get install python3-pip

#INSTALL DOCKER, PORTAINER, DOCKER COMPOSE
curl -fsSL https://get.docker.com -o get-docker.sh
yes | sudo sh get-docker.sh
sudo usermod -aG docker pi
sudo newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
cd

docker pull portainer/portainer-ce:latest
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

sudo curl -L --fail https://github.com/docker/compose/releases/download/1.29.2/run.sh -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#REBOOTS THE RASPBERRY PI
sudo reboot

#!/bin/bash

#UPDATES TO NEWEST RASPBIAN FIRMWARE
sudo apt update
sudo apt full-upgrade

#TURN OFF WIFI AND BLUETOOTH
sudo echo "dtoverlay=pi3-disable-wifi" >> /boot/config.txt
sudo echo "dtoverlay=pi3-disable-bt" >> /boot/config.txt

#INSTALL PYTHON3
sudo apt-get install python-pip

#INSTALL DOCKER, PORTAINER, DOCKER COMPOSE
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo groupadd docker
sudo usermod -aG docker pi
sudo newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo docker pull portainer/portainer-ce:latest
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

sudo curl -L --fail https://github.com/docker/compose/releases/download/1.29.2/run.sh -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

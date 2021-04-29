#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi

sudo apt update
sudo apt install -y docker.io
sudo usermod -aG docker $(whoami)

echo "Please log out and log back in to use docker"
echo "Start docker deamon with: sudo dockerd"

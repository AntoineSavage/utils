#!/bin/bash

if [ `whoami` != 'root' ]; then echo "This program must be run using 'sudo'"; exit; fi

apt update
apt install -y docker.io
usermod -aG docker asavage

echo "Please log out and log back in to use docker"
echo "Start docker deamon with: sudo dockerd"
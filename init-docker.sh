#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run as 'sudo'"; exit; fi

echo "===================="
echo "Getting authorization"
sudo echo ''

# Refresh sudo credentials every minute
while :; do sudo -v; sleep 59; done &
refresh_sudo=$!

echo "===================="
echo "Upgrade apt"
sudo apt update
sudo apt upgrade -y

echo "===================="
echo "Install docker"
sudo apt install -y docker.io
npm install -g npm

echo "===================="
echo "Init docker"
sudo usermod -aG docker asavage

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm init-docker.sh
kill "$refresh_sudo"

echo "===================="
echo "Completed. Please log out and log back in for docker group changes to take effect"

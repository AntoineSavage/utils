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
echo "Install java"
sudo apt install -y openjdk-13-jdk maven

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm init-java.sh
kill "$refresh_sudo"

#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run as 'sudo'"; exit; fi

echo "===================="
echo "Getting authorization"
sudo echo ''

# Refresh sudo credentials every minute
while :; do sudo -v; sleep 59; done &
refresh_sudo=$!

echo "===================="
echo "Create temp directory"
rm -rf init-python-tmp
mkdir init-python-tmp
cd init-python-tmp

echo "===================="
echo "Upgrade apt"
sudo apt update
sudo apt upgrade -y

echo "===================="
echo "Install pip"
sudo apt install -y python3-pip

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm -rf init-python-tmp
rm init-python.sh
kill "$refresh_sudo"

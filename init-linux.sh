#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run as 'sudo'"; exit; fi

echo "===================="
echo "Getting authorization"
sudo echo ''

# Refresh sudo credentials every minute
while :; do sudo -v; sleep 59; done &
refresh_sudo=$!

echo "===================="
echo "Configure SSH for github"
echo "Use default file location!"
echo "Use a strong password!"
ssh-keygen -t ed25519 -C "antoine.savage@github.com"
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519.pub

echo "===================="
cat ~/.ssh/id_ed25519.pub
echo "===================="

echo "===================="
echo "Configure ~/.bashrc"
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
echo 'eval $(keychain --eval id_ed25519)' >> ~/.bashrc

echo "===================="
echo "Configure npm folder ownership"
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

echo "===================="
echo "Configure git"
git config --global user.name "Antoine Savage"
git config --global user.email "antoine.savage@gmail.com"

echo "===================="
echo "Create temp directory"
rm -rf init-linux-tmp
mkdir init-linux-tmp
cd init-linux-tmp

echo "===================="
echo "Upgrade apt"
sudo apt update
sudo apt upgrade -y

echo "===================="
echo "Install dependency packages"
sudo apt install -y keychain zip unzip libtinfo-dev g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm -rf init-linux-tmp
rm init-linux.sh
kill "$refresh_sudo"

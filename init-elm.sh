#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run as 'sudo'"; exit; fi

echo "===================="
echo "Getting authorization"
sudo echo ''

# Refresh sudo credentials every minute
while :; do sudo -v; sleep 59; done &
refresh_sudo=$!

echo "===================="
echo "Configure npm folder ownership"
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

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
echo "Install npm"
sudo apt install -y npm
npm install -g npm

echo "===================="
echo "Install elm modules"
npm install -g elm elm-format elm-test
npm install -g create-elm-app # must be installed separately

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm -rf init-linux-tmp
rm init-linux.sh
kill "$refresh_sudo"

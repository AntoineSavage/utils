#!/bin/bash

# copy/paste the following line
# wget https://raw.githubusercontent.com/AntoineSavage/utils/main/init-linux.sh

# If localhost is unreachable from windows
# (from linux) ip addr | grep eth0
# copy the ip after 'inet'
# it's the same ip displayed by elm-app start

echo "===================="
echo "Create temp directory"
mkdir init-linux-tmp
cd init-linux-tmp

echo "===================="
echo "Upgrade apt"
sudo apt update
echo y | sudo apt upgrade

echo "===================="
echo "Install pip"
echo y | sudo apt install python3-pip
sudo pip3 --version
sudo python3 --version
pip3 --version
python3 --version

echo "===================="
echo "Install npm"
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
echo y | sudo apt install npm
npm install -g npm
npm --version

echo "===================="
echo "Install elm"
npm install -g elm
elm --version

echo "===================="
echo "Install elm-format"
npm install -g elm-format
elm-format -h

echo "===================="
echo "Install elm-test"
npm install -g elm-test
elm-test --version

echo "===================="
echo "Install create-elm-app"
npm install -g create-elm-app
create-elm-app temp2
cd temp2
sudo elm-app test
cd ..

echo "===================="
echo "Clean-up"
cd ..
sudo rm -rf init-linux-tmp
rm init-linux.sh

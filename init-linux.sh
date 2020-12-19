#!/bin/bash

# copy/paste the following line
# mv /mnt/c/Users/antoi/Desktop/init-linux.sh ~/init-linux.sh && sh ~/init-linux.sh

echo "===================="
echo "Create temp directory"
mkdir init-linux-tmp
cd init-linux-tmp

echo "===================="
echo "Install npm"
sudo apt update
echo y | sudo apt upgrade
echo y | sudo apt install npm 

echo "===================="
echo "Install elm"
sudo npm install -g elm
sudo elm --version
elm --version

echo "===================="
echo "Install elm-format"
sudo npm install -g elm-format
sudo elm-format -h
elm-format -h

echo "===================="
echo "Install elm-test"
sudo npm install -g elm-test
sudo elm-test --version
elm-test --version

echo "===================="
echo "Install create-elm-app"
sudo npm install -g create-elm-app
sudo create-elm-app temp1
create-elm-app temp2

echo "===================="
echo "Clean-up"
cd ..
sudo rm -rf init-linux-tmp
rm init-linux.sh

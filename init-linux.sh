#!/bin/bash

# copy/paste the following line
# mv /mnt/c/Users/antoi/Desktop/init-linux.sh ~/init-linux.sh && sh ~/init-linux.sh

# haskell projects:
# create new file hie.yaml with content:
# cradle:
#   stack:

# If localhost is unreachable from windows
# (from linux) ip addr | grep eth0
# copy the ip after 'inet'
# it's the same ip displayed by elm-app start

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
cd temp2
sudo elm-app test
cd ..

echo "===================="
echo "Install haskell stack"
wget -qO- https://get.haskellstack.org/ | sh
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
stack update
stack upgrade
stack new temp3
cd temp3
stack test
cd ..

echo "===================="
echo "Clean-up"
cd ..
sudo rm -rf init-linux-tmp
rm init-linux.sh

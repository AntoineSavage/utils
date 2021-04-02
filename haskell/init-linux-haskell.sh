#!/bin/bash

# copy/paste the following line
# wget https://raw.githubusercontent.com/AntoineSavage/utils/main/haskell/init-linux-haskell.sh && sudo sh init-linux-haskell.sh

# If localhost is unreachable from windows
# (in linux) ip addr | grep eth0
# copy the ip after 'inet'
# it's the same ip displayed by elm-app start

echo "===================="
echo "Run init-linux"
sudo wget https://raw.githubusercontent.com/AntoineSavage/utils/main/init-linux.sh && sh init-linux.sh

echo "===================="
echo "Create temp directory"
mkdir init-linux-tmp
cd init-linux-tmp

echo "===================="
echo "Install haskell stack"
wget -qO- https://get.haskellstack.org/ | sh
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
stack update
stack upgrade
stack new temp3
cd temp3
stack test
stack install hspec QuickCheck sensei servant parsec
cd ..

echo "===================="
echo "Clean-up"
cd ..
sudo rm -rf init-linux-tmp
rm init-linux-haskell.sh
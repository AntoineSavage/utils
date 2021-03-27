#!/bin/bash

# copy/paste the following line
# mv /mnt/c/Users/antoi/Desktop/init-linux-haskell.sh ~/init-linux-haskell.sh && sh ~/init-linux-haskell.sh

# haskell projects:
# create new file hie.yaml with content:
# cradle:
#   stack:

# If localhost is unreachable from windows
# (in linux) ip addr | grep eth0
# copy the ip after 'inet'
# it's the same ip displayed by elm-app start

echo "===================="
echo "Run init-linux"
mv /mnt/c/Users/antoi/Desktop/init-linux.sh ~/init-linux.sh && sh ~/init-linux.sh

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
cd ..

echo "===================="
echo "Clean-up"
cd ..
sudo rm -rf init-linux-tmp
rm init-linux-haskell.sh

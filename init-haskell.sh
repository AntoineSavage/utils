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
rm -rf init-haskell-tmp
mkdir init-haskell-tmp
cd init-haskell-tmp

echo "===================="
echo "Install haskell"
wget https://get.haskellstack.org/stable/linux-x86_64.tar.gz
gzip -d linux-x86_64.tar.gz
tar -xvf linux-x86_64.tar
sudo install -c -o 0 -g 0 -m 0755 stack*linux*/stack /usr/local/bin
stack update
stack upgrade
sed -i 's/#    author-name:/    author-name: Antoine Savage/g' ~/.stack/config.yaml
sed -i 's/#    author-email:/    author-email: antoine.savage@gmail.com/g' ~/.stack/config.yaml
sed -i 's/#    github-username:/    github-username: AntoineSavage/g' ~/.stack/config.yaml
sed -i 's/#    copyright://g' ~/.stack/config.yaml

echo "===================="
echo "Pre-compile haskell packages"
rm -rf temp
stack new temp
cd temp
stack install aeson async containers doctest hspec parsec postgresql-typed QuickCheck sensei servant stm text time utf8-string wai wai-cors wai-websockets warp websockets
stack build
cd ..

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm -rf init-haskell-tmp
rm init-haskell.sh
kill "$refresh_sudo"

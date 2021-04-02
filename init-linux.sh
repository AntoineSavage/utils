#!/bin/bash

# copy/paste the following line
# sudo wget https://raw.githubusercontent.com/AntoineSavage/utils/main/init-linux.sh && sh init-linux.sh

# Elm format-on-save in vscode:
# Ctrl+Shift+P, open settings (JSON)
#
# Add the following key:
# "[elm]": {
#     "editor.formatOnSave": true
# },

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
echo "Install postgres"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
echo y | sudo apt-get install postgresql zip unzip

echo "===================="
echo "Install postgres sample databse"
sudo /bin/su -c "\
    pg_ctlcluster 13 main start \
    psql -c 'create database dvdrental;' \
    curl -O https://sp.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip \
    unzip dvdrental.zip \
    rm dvdrental.zip \
    pg_restore --dbname=dvdrental --verbose dvdrental.tar \
    rm dvdrental.tar \
    " - postgres



echo "===================="
echo "Clean-up"
cd ..
sudo rm -rf init-linux-tmp
rm init-linux.sh

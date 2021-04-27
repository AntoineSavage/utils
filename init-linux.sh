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
echo "Install packages (pip, npm, elixir, postgresql, openjdk, docker, ...)"
sudo apt install -y python3-pip npm elixir postgresql postgresql-contrib openjdk-13-jdk docker.io maven keychain zip unzip libtinfo-dev g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase
npm install -g npm

echo "===================="
echo "Install elm modules"
npm install -g elm elm-format elm-test
npm install -g create-elm-app # must be installed separately

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
echo "Init postgres DB"
rm -rf temp
mkdir temp
cd temp
echo 'postgres:postgres' | sudo chpasswd
sudo service postgresql start
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql -c "create database dvdrental;"
curl -O https://sp.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip
sudo -u postgres pg_restore --dbname=dvdrental --verbose dvdrental.tar
sudo service postgresql stop
cd ..
rm -rf temp

echo "===================="
echo "Init docker"
sudo usermod -aG docker asavage
newgrp docker

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm -rf init-linux-tmp
rm init-linux.sh
kill "$refresh_sudo"

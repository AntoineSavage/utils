#!/bin/bash

# copy/paste the following line
# wget -q https://raw.githubusercontent.com/AntoineSavage/utils/main/init-linux.sh && sh init-linux.sh

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

sudo echo ''

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
echo y | sudo apt upgrade

echo "===================="
echo "Install pip"
echo y | sudo apt install python3-pip
pip3 --version
python3 --version

echo "===================="
echo "Install npm"
echo y | sudo apt install npm
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
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
elm-app test
cd ..

echo "===================="
echo "Install haskell stack"
sudo apt-get install libtinfo-dev 
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
wget -qO - https://get.haskellstack.org/ | sh
stack update
stack upgrade
sed -i 's/#    author-name:/    author-name: Antoine Savage/g' ~/.stack/config.yaml
sed -i 's/#    author-email:/    author-email: antoine.savage@gmail.com/g' ~/.stack/config.yaml
sed -i 's/#    github-username:/    github-username: AntoineSavage/g' ~/.stack/config.yaml
sed -i 's/#    copyright://g' ~/.stack/config.yaml
stack new temp3
cd temp3
stack test
stack install aeson async doctest hspec parsec QuickCheck sensei servant stm wai wai-websockets warp websockets
cd ..

echo "===================="
echo "Install postgres"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
echo y | sudo apt upgrade
echo y | sudo apt-get install postgresql zip unzip

echo "===================="
echo "Install postgres sample db"
sudo su -c "wget -q https://raw.githubusercontent.com/AntoineSavage/utils/main/init-postgres.sh && sh init-postgres.sh" - postgres

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm -rf init-linux-tmp
rm init-linux.sh

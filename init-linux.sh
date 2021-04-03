#!/bin/bash

# copy/paste the following line
# wget -q https://raw.githubusercontent.com/AntoineSavage/utils/main/init-linux.sh && sh init-linux.sh

# Add SSH key to github account
# https://github.com/settings/ssh/new
# cat ~/.ssh/id_ed25519.pub

# Elm format-on-save in vscode:
# Ctrl+Shift+P, open settings (JSON)
# Add the following key:
# "[elm]": {
#     "editor.formatOnSave": true
# },

# stack install aeson async doctest hspec parsec QuickCheck sensei servant stm wai wai-websockets warp websockets

# If localhost is unreachable from windows
# (from linux) ip addr | grep eth0
# copy the ip after 'inet'
# it's the same ip displayed by elm-app start

echo "===================="
echo "Getting authorization"
sudo echo ''

echo "===================="
echo "Configure SSH for github"
echo "Use default file location!"
echo "Use a strong password!"
ssh-keygen -t ed25519 -C "antoine.savage@github.com"
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519.pub

echo "===================="
echo "Configure ~/.bashrc"
echo 'export PATH=$HOME/.local/bin:$PATH'                  >> ~/.bashrc
echo ''                                                    >> ~/.bashrc
echo 'if [ ! -S ~/.ssh/ssh_auth_sock ]; then'              >> ~/.bashrc
echo '  eval `ssh-agent`'                                  >> ~/.bashrc
echo '  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock'      >> ~/.bashrc
echo 'fi'                                                  >> ~/.bashrc
echo 'export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock'           >> ~/.bashrc
echo 'ssh-add -l > /dev/null || ssh-add ~/.ssh/id_ed25519' >> ~/.bashrc
echo ''                                                    >> ~/.bashrc
source ~/.bashrc

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
echo y | sudo apt upgrade

echo "===================="
echo "Install pip and npm"
echo y | sudo apt install python3-pip npm libtinfo-dev zip unzip
npm install -g npm

echo "===================="
echo "Test pip and npm"
pip3 --version
python3 --version
npm --version

echo "===================="
echo "Install elm modules"
npm install -g elm elm-format elm-test create-elm-app

echo "===================="
echo "Test elm modules"
elm --version
elm-format -h
elm-test --version
rm -rf temp
create-elm-app temp
cd temp
elm-app test
cd ..
rm -rf temp

echo "===================="
echo "Install haskell"
wget -qO - https://get.haskellstack.org/ | sh
stack update
stack upgrade
sed -i 's/#    author-name:/    author-name: Antoine Savage/g' ~/.stack/config.yaml
sed -i 's/#    author-email:/    author-email: antoine.savage@gmail.com/g' ~/.stack/config.yaml
sed -i 's/#    github-username:/    github-username: AntoineSavage/g' ~/.stack/config.yaml
sed -i 's/#    copyright://g' ~/.stack/config.yaml

echo "===================="
echo "Test haskell"
rm -rf temp
stack new temp
cd temp
stack test
cd ..
rm -rf temp

echo "===================="
echo "Install postgres"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
echo y | sudo apt upgrade
echo y | sudo apt-get install postgresql

echo "===================="
echo "Install postgres sample db"
sudo su -c "wget -q https://raw.githubusercontent.com/AntoineSavage/utils/main/init-postgres.sh && sh init-postgres.sh" - postgres

echo "===================="
echo "Clean-up"
cd ..
sudo apt autoremove
rm -rf init-linux-tmp
rm init-linux.sh

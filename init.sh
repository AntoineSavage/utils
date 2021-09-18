#!/bin/bash

# Constants
USER_NAME="Antoine Savage"
USER_EMAIL="antoine.savage@gmail.com"
GITHUB_USERNAME="AntoineSavage"

echo "=================================================="
echo "=================================================="
echo "                Set up credentials                "
echo "=================================================="
echo "=================================================="
if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi
sudo -v
while true; do sleep 60; sudo -v; done &
pid=$!

echo "=================================================="
echo "=================================================="
echo "                 Init git and ssh                 "
echo "=================================================="
echo "=================================================="
git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL

ssh-keygen -q -t ed25519 -f ~/.ssh/id_ed25519 -N '' -C $USER_EMAIL <<<y 2>&1 >/dev/null
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519.pub
echo 'eval $(keychain --eval id_ed25519)' >> ~/.bashrc

echo "=================================================="
echo "=================================================="
echo "Add the following to github account: https://github.com/settings/ssh/new"
cat ~/.ssh/id_ed25519.pub
echo "=================================================="
echo "=================================================="

echo "=================================================="
echo "=================================================="
echo "                 Install packages                 "
echo "=================================================="
echo "=================================================="
sudo apt update
sudo apt install -y keychain npm libffi-dev libgmp-dev libtinfo-dev libz-dev

echo "=================================================="
echo "=================================================="
echo "                   Install elm                    "
echo "=================================================="
echo "=================================================="
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
npm install -g npm
npm install -g elm elm-format elm-test
npm install -g create-elm-app # must be installed separately

echo "=================================================="
echo "=================================================="
echo "                 Install haskell                  "
echo "=================================================="
echo "=================================================="
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
rm -rf temp
mkdir temp
cd temp
wget https://get.haskellstack.org/stable/linux-x86_64.tar.gz
gzip -d linux-x86_64.tar.gz
tar -xvf linux-x86_64.tar
sudo install -c -o 0 -g 0 -m 0755 stack*linux*/stack /usr/local/bin
stack update
stack upgrade
sed -i "s/#    author-name:/    author-name: $USER_NAME/g" ~/.stack/config.yaml
sed -i "s/#    author-email:/    author-email: $USER_EMAIL/g" ~/.stack/config.yaml
sed -i "s/#    github-username:/    github-username: $GITHUB_USERNAME/g" ~/.stack/config.yaml
sed -i "s/#    copyright://g" ~/.stack/config.yaml
cd ..
rm -rf temp
stack new temp
cd temp
stack build
cd ..
rm -rf temp

echo "=================================================="
echo "=================================================="
echo "                     Clean-up                     "
echo "=================================================="
echo "=================================================="
kill $pid

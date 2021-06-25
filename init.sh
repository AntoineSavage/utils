#!/bin/bash

# Constants
USER_NAME="Antoine Savage"
USER_EMAIL="antoine.savage@gmail.com"
GITHUB_USERNAME="AntoineSavage"

# Credentials
if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi
sudo -v
while true; do sleep 60; sudo -v; done &
pid=$!

# Init git & ssh
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

# Install exercism
rm -rf temp
mkdir temp
cd temp
wget https://github.com/exercism/cli/releases/download/v3.0.13/exercism-linux-64bit.tgz
tar -xf exercism-linux-64bit.tgz
sudo mv exercism /usr/bin
cd ..
rm -rf temp

# Register google cloud sdk in apt
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Install packages
sudo apt update
sudo apt install -y docker.io docker-compose google-cloud-sdk google-cloud-sdk-app-engine-python keychain npm python3-venv python3-pip

# Install dependency packages
sudo apt install -y libffi-dev libgmp-dev libtinfo-dev

# Init docker
sudo usermod -aG docker $(whoami)

# Install elm
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
npm install -g npm
npm install -g elm elm-format elm-test
npm install -g create-elm-app # must be installed separately

# Install haskell
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

# Clean-up
kill $pid
echo "Please log out and log back in to use docker"

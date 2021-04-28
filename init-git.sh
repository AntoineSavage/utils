#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi

sudo apt update
sudo apt install -y keychain

git config --global user.name "Antoine Savage"
git config --global user.email "antoine.savage@gmail.com"

ssh-keygen -q -t ed25519 -f ~/.ssh/id_ed25519 -N '' -C "antoine.savage@github.com" <<<y 2>&1 >/dev/null
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519.pub
echo 'eval $(keychain --eval id_ed25519)' >> ~/.bashrc

echo "Add the following to github account: https://github.com/settings/ssh/new"
cat ~/.ssh/id_ed25519.pub
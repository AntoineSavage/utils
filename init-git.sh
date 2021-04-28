#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run as 'sudo'"; exit; fi

ssh-keygen -f ~/.ssh/id_ed25519 -N '' -t ed25519 -C "antoine.savage@github.com"
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519.pub
echo 'eval $(keychain --eval id_ed25519)' >> ~/.bashrc

git config --global user.name "Antoine Savage"
git config --global user.email "antoine.savage@gmail.com"

echo "===================="
echo "Add the following to github account: https://github.com/settings/ssh/new"
cat ~/.ssh/id_ed25519.pub

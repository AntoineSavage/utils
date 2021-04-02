#! /bin/bash

# copy/paste the following line:
# wget -q https://raw.githubusercontent.com/AntoineSavage/utils/main/init-ssh.sh && sh init-ssh.sh

# Then go to: https://github.com/settings/ssh/new
# Run: cat ~/.ssh/id_rsa.pub
# Copy/paste the output in the browser window

ssh-keygen -t rsa -b 4096 -C "antoine.savage@github.com"
eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa

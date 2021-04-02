#! /bin/bash

# copy/paste the following line:
# wget -q https://raw.githubusercontent.com/AntoineSavage/utils/main/init-ssh.sh && sh init-ssh.sh

# Then go to: https://github.com/settings/ssh/new
# Run: cat ~/.ssh/id_rsa.pub
# Copy/paste the output in the browser window

# Make sure to enter a strong password
ssh-keygen -t rsa -b 4096 -C "antoine.savage@github.com"

# Run this line if no ssh-agent is currently running
# eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa

# Clean-up
rm init-ssh.sh

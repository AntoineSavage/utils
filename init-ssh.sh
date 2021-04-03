#! /bin/bash

# copy/paste the following line:
# wget -q https://raw.githubusercontent.com/AntoineSavage/utils/main/init-ssh.sh && sh init-ssh.sh

# Make sure to enter a strong password
ssh-keygen -t ed25519 -C "antoine.savage@github.com"
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519.pub

if ! pgrep -x "ssh-agent" > /dev/null
then eval `ssh-agent -s`
fi

ssh-add ~/.ssh/id_ed25519

# Clean-up
rm init-ssh.sh

# Then go to: https://github.com/settings/ssh/new
# cat ~/.ssh/id_ed25519.pub
# Copy/paste the output in the browser window
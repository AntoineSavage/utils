#!/bin/bash

# get sudo credentials
sudo echo ''

# Refresh sudo credentials every minute
while :; do sudo -v; sleep 59; done &
refresh_sudo=$!

# Update and install packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y g++ gcc gnupg libc6-dev libffi-dev libgmp-dev libtinfo-dev make netbase unzip xz-utils zlib1g-dev zip

# Clean-up
kill "$refresh_sudo"

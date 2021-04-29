#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run as 'sudo'"; exit; fi

sudo apt update
sudo apt upgrade -y
sudo apt install -y g++ gcc gnupg libc6-dev libffi-dev libgmp-dev libtinfo-dev make netbase unzip xz-utils zlib1g-dev zip

#!/bin/bash

if [ `whoami` != 'root' ]; then echo "This program must be run using 'sudo'"; exit; fi

chown -R asavage /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

apt update
apt install -y npm
sudo -u asavage npm install -g npm
sudo -u asavage npm install -g elm elm-format elm-test
sudo -u asavage npm install -g create-elm-app # must be installed separately
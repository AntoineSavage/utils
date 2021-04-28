#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi

sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

sudo apt update
sudo apt install -y npm
npm install -g npm
npm install -g elm elm-format elm-test
npm install -g create-elm-app # must be installed separately

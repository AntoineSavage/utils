#!/bin/bash

if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi
sudo -v

rm -rf temp
mkdir temp
cd temp

wget https://github.com/exercism/cli/releases/download/v3.0.13/exercism-linux-64bit.tgz
tar -xf exercism-linux-64bit.tgz
sudo mv exercism /usr/bin
exercism version

cd ..
rm -rf temp

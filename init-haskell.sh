#!/bin/bash

if [ `whoami` != 'root' ]; then echo "This program must be run using 'sudo'"; exit; fi

echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

rm -rf temp
mkdir temp
cd temp

wget https://get.haskellstack.org/stable/linux-x86_64.tar.gz
gzip -d linux-x86_64.tar.gz
tar -xvf linux-x86_64.tar
install -c -o 0 -g 0 -m 0755 stack*linux*/stack /usr/local/bin
stack update
stack upgrade
sed -i 's/#    author-name:/    author-name: Antoine Savage/g' ~/.stack/config.yaml
sed -i 's/#    author-email:/    author-email: antoine.savage@gmail.com/g' ~/.stack/config.yaml
sed -i 's/#    github-username:/    github-username: AntoineSavage/g' ~/.stack/config.yaml
sed -i 's/#    copyright://g' ~/.stack/config.yaml

cd ..
rm -rf temp
stack new temp
cd temp
stack install aeson async containers doctest hspec parsec postgresql-typed QuickCheck sensei servant stm text time utf8-string wai wai-cors wai-websockets warp websockets
stack build

cd ..
rm -rf temp

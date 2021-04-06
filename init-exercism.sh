#! /bin/bash

# copy/paste the following line
# wget -qO init-exercism.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-exercism.sh && bash init-exercism.sh

# Then get token from: https://exercism.io/my/settings
# exercism configure --token=THE_TOKEN

sudo echo ''

rm -rf temp
mkdir temp
cd temp

wget https://github.com/exercism/cli/releases/download/v3.0.13/exercism-linux-64bit.tgz
tar -xf exercism-linux-64bit.tgz
sudo mv exercism /usr/bin
exercism version

cd ..
rm -rf temp

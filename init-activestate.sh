#! /bin/bash

# Requirements (windows-side)
# - Git for windows
# - Git credential manager (core install, not user install)

# Inputs
USER_NAME="Antoine Savage"
USER_EMAIL="antoines@activestate.com"

echo "=================================================="
echo "=================================================="
echo "             Set-up sudo credentials              "
echo "=================================================="
echo "=================================================="
if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi
sudo -v
while true; do sleep 60; sudo -v; done &
pid=$!

echo "=================================================="
echo "=================================================="
echo "                    Update PATH                   "
echo "=================================================="
echo "=================================================="
echo ""                                                         >> ~/.profile
echo "# set PATH so it includes user's yarn bin if it exists"   >> ~/.profile
echo 'if [ -d "$HOME/.yarn/bin" ] ; then'                       >> ~/.profile
echo '    PATH="$HOME/.yarn/bin:$PATH"'                         >> ~/.profile
echo "fi"                                                       >> ~/.profile

echo "=================================================="
echo "=================================================="
echo "                 Init git config                  "
echo "=================================================="
echo "=================================================="
git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"

echo "=================================================="
echo "=================================================="
echo "                Add packages sites                "
echo "=================================================="
echo "=================================================="
sudo add-apt-repository -y ppa:longsleep/golang-backports
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -

echo "=================================================="
echo "=================================================="
echo "                 Install packages                 "
echo "=================================================="
echo "=================================================="
sudo apt update
sudo apt install -y golang-go nodejs build-essential perl curl libssl-dev zlib1g-dev python3-pip sqitch libdbd-pg-perl postgresql-client

echo "=================================================="
echo "=================================================="
echo "                    Install yarn                  "
echo "=================================================="
echo "=================================================="
sudo npm install --g yarn

echo "=================================================="
echo "=================================================="
echo "                    Install elm                  "
echo "=================================================="
echo "=================================================="
yarn global add elm elm-test elm-format@0.8.1

echo "=================================================="
echo "=================================================="
echo "                   Install bazel                  "
echo "=================================================="
echo "=================================================="
mkdir -p $HOME/bin
export GOBIN=$HOME/bin
go install github.com/bazelbuild/bazelisk@latest
sudo ln -sf $HOME/bin/bazelisk /usr/local/bin/bazel

echo "=================================================="
echo "=================================================="
echo "                Clone TheHomeRepot                "
echo "=================================================="
echo "=================================================="
mkdir github
cd github
git clone https://github.com/ActiveState/TheHomeRepot.git
cd TheHomeRepot

echo "=================================================="
echo "=================================================="
echo "                Install dev tools                 "
echo "=================================================="
echo "=================================================="
./install-dev-tools.sh

echo "=================================================="
echo "=================================================="
echo "                     Clean-up                     "
echo "=================================================="
echo "=================================================="
source ~/.profile
kill $pid

#! /bin/bash

# Requirements (windows-side)
# - Git for windows
# - Git credential manager (core install, not user install)
# - VSCode, with WSL extension

# Inputs
USER_NAME="Antoine Savage"
USER_EMAIL="antoines@activestate.com"
GITHUB_USERNAME="antoine-activestate"

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
echo ""                                                         >> ~/.profile
echo "eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`"            >> ~/.profile

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
sudo apt install -y docker.io golang-go nodejs build-essential perl curl libssl-dev zlib1g-dev python3-pip sqitch libdbd-pg-perl postgresql-client libffi-dev libgmp-dev libtinfo-dev libz-dev

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
echo "                 Install haskell                  "
echo "=================================================="
echo "=================================================="
rm -rf temp
mkdir temp
cd temp
wget https://get.haskellstack.org/stable/linux-x86_64.tar.gz
gzip -d linux-x86_64.tar.gz
tar -xvf linux-x86_64.tar
sudo install -c -o 0 -g 0 -m 0755 stack*linux*/stack /usr/local/bin
stack update
stack upgrade
sed -i "s/#    author-name:/    author-name: $USER_NAME/g" ~/.stack/config.yaml
sed -i "s/#    author-email:/    author-email: $USER_EMAIL/g" ~/.stack/config.yaml
sed -i "s/#    github-username:/    github-username: $GITHUB_USERNAME/g" ~/.stack/config.yaml
sed -i "s/#    copyright://g" ~/.stack/config.yaml
cd ..
rm -rf temp
stack new temp
cd temp
stack install aeson async containers doctest hspec parsec postgresql-typed QuickCheck sensei servant stm text time utf8-string wai wai-cors wai-websockets warp websockets
stack build
cd ..
rm -rf temp

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
mkdir -p github
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
echo "            Install vscode extensions             "
echo "=================================================="
echo "=================================================="
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension donjayamanne.githistory
code --install-extension dramforever.vscode-ghc-simple
code --install-extension elmTooling.elm-ls-vscode
code --install-extension golang.go
code --install-extension haskell.haskell
code --install-extension hbenl.vscode-test-explorer
code --install-extension justusadam.language-haskell
code --install-extension mhutchie.git-graph
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-vscode.test-adapter-converter
code --install-extension waderyan.gitblame

echo "=================================================="
echo "=================================================="
echo "                     Clean-up                     "
echo "=================================================="
echo "=================================================="
source ~/.profile
kill $pid

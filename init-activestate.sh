#! /bin/bash

# Exit if any command fails
set -e

# Requirements (windows-side)
# - Git for windows
# - Git credential manager (core install, not user install)
# - VSCode, with WSL extension

# Inputs
USER_NAME="Antoine Savage"
USER_EMAIL="antoines@activestate.com"
GITHUB_USERNAME="antoine-activestate"
UNIX_USERNAME="antoines"

echo "=================================================="
echo "=================================================="
echo "                 Configure user                   "
echo "=================================================="
echo "=================================================="
if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi
sudo -v
bash -c "while true; do sleep 10; sudo -v; done" &

echo ""                                                                     >> ~/.profile
echo "# set PATH so it includes user's yarn bin if it exists"               >> ~/.profile
echo 'if [ -d "$HOME/.yarn/bin" ] ; then'                                   >> ~/.profile
echo '    PATH="$HOME/.yarn/bin:$PATH"'                                     >> ~/.profile
echo "fi"                                                                   >> ~/.profile
echo ""                                                                     >> ~/.profile
echo 'PATH="$HOME/github/TheHomeRepot/third_party/bin:$PATH"'               >> ~/.profile
echo 'PATH="$HOME/.local/bin:$PATH"'                                        >> ~/.profile
echo 'alias clear="TERMINFO=/usr/share/terminfo TERM=xterm /usr/bin/clear"' >> ~/.bashrc
echo 'AWS_PROFILE=sso'                                                      >> ~/.bashrc

git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"

sudo groupadd docker
sudo usermod -aG docker $USER

sudo bash -c "echo -e '[user]\ndefault=$UNIX_USERNAME' >> /etc/wsl.conf"

mkdir -p ~/.aws
touch ~/.aws/config

sudo apt update && sudo apt upgrade
sudo do-release-upgrade

echo "=================================================="
echo "=================================================="
echo "                Add packages sites                "
echo "=================================================="
echo "=================================================="
sudo add-apt-repository -y ppa:longsleep/golang-backports
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash -

echo "=================================================="
echo "=================================================="
echo "                 Install packages                 "
echo "=================================================="
echo "=================================================="
sudo apt update
sudo apt upgrade -y
sudo apt install -y awscli build-essential curl default-jre docker.io golang-go hugo libgtk2.0-0 libgtk-3-0 libgbm-dev libncurses5 libncurses-dev libnotify-dev libnss3 libxss1 libasound2 libxtst6 xauth xvfb libdbd-pg-perl libffi7 libffi-dev libgmp10 libgmp-dev libssl-dev libtinfo5 libtinfo-dev libz-dev nodejs perl postgresql-client python3 python-is-python3 python3-pip sqitch zlib1g-dev

echo "=================================================="
echo "=================================================="
echo "                  Configure sqitch                "
echo "=================================================="
echo "=================================================="
sqitch config --user user.name $USER_NAME
sqitch config --user user.email $USER_EMAIL

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
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 BOOTSTRAP_HASKELL_INSTALL_STACK=1 BOOTSTRAP_HASKELL_INSTALL_HLS=1 BOOTSTRAP_HASKELL_ADJUST_BASHRC=1 sh
source $HOME/.ghcup/env
stack config set install-ghc false --global
stack config set system-ghc  true  --global

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
echo "                 Install swagger                  "
echo "=================================================="
echo "=================================================="
go get -u github.com/go-swagger/go-swagger/cmd/swagger
cp ~/github/TheHomeRepot/third_party/bin/swagger-codegen-cli.jar ~/bin

echo "=================================================="
echo "=================================================="
echo "            Install vscode extensions             "
echo "=================================================="
echo "=================================================="
code --install-extension bcanzanella.openmatchingfiles
code --install-extension davidanson.vscode-markdownlint
code --install-extension donjayamanne.githistory
code --install-extension dramforever.vscode-ghc-simple
code --install-extension elmtooling.elm-ls-vscode
code --install-extension fabiospampinato.vscode-open-in-github
code --install-extension golang.go
code --install-extension graphql.vscode-graphql
code --install-extension graphql.vscode-graphql-syntax
code --install-extension haskell.haskell
code --install-extension hbenl.vscode-test-explorer
code --install-extension justusadam.language-haskell
code --install-extension littlefoxteam.vscode-python-test-adapter
code --install-extension mhutchie.git-graph
code --install-extension ms-python.debugpy
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-toolsai.vscode-jupyter-cell-tags
code --install-extension ms-toolsai.vscode-jupyter-slideshow
code --install-extension ms-vscode.live-server
code --install-extension ms-vscode.test-adapter-converter
code --install-extension redhat.vscode-yaml
code --install-extension shardulm94.trailing-spaces
code --install-extension tyriar.sort-lines
code --install-extension waderyan.gitblame

echo "=================================================="
echo "=================================================="
echo "              Install the State Tool              "
echo "=================================================="
echo "=================================================="
sh <(curl -q https://platform.activestate.com/dl/cli/install.sh)
rm third_party/bin/state

echo "=================================================="
echo "=================================================="
echo "                     Clean-up                     "
echo "=================================================="
echo "=================================================="

echo "Run in powershell: wsl --shutdown"

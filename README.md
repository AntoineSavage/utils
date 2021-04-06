# utils

Various utilities for my own personal use

Public to allow access to files without credentials

# init-linux
wget -qO init-linux.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-linux.sh && bash init-linux.sh && source ~/.bashrc

Add SSH key to github account: https://github.com/settings/ssh/new

Elm format-on-save in vscode:
Ctrl+Shift+P, open settings (JSON)
Add the following key:
"[elm]": {
    "editor.formatOnSave": true
},

If localhost is unreachable from windows
(from linux) ip addr | grep eth0
copy the ip after 'inet'
it's the same ip displayed by elm-app start

# init-haskell
wget -qO init-haskell.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-haskell.sh && bash init-haskell.sh

# init-exercism
wget -qO init-exercism.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-exercism.sh && bash init-exercism.sh

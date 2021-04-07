# init-linux
```bash
wget -qO init-linux.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-linux.sh && bash init-linux.sh && source ~/.bashrc
```

Add SSH key to github account: https://github.com/settings/ssh/new

## Elm format-on-save in vscode
Ctrl+Shift+P, open settings (JSON), then add the following key:
```json
"[elm]": {
    "editor.formatOnSave": true
},
```

## If linux localhost is unreachable from windows
Run the following in linux:
```bash
ip addr | grep eth0
```
then copy the ip after 'inet', it's the same ip displayed by elm-app start

# init-haskell
```bash
wget -qO init-haskell.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-haskell.sh && bash init-haskell.sh
```

# init-exercism
```bash
wget -qO init-exercism.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-exercism.sh && bash init-exercism.sh
```

Then get token from: https://exercism.io/my/settings
```bash
exercism configure --token=${THE_TOKEN}
```

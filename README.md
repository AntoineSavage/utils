# WSL Ubuntu Setup

Username assumed to be 'asavage'

## 1) Configure SSH for git
```bash
wget -qO init-git.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-git.sh && bash init-git.sh && rm init-git.sh && source ~/.bashrc
```

Add SSH key to github account: https://github.com/settings/ssh/new

## 2) Checkout this repository
```
echo yes | git clone git@github.com:AntoineSavage/utils.git && utils/init-packages.sh
```

## 3) Install dependency packages
```
utils/init-packages.sh
```

## 3) Install specific components (all optional):
```
utils/init-docker.sh
utils/init-elixir.sh
utils/init-elm.sh
utils/init-haskell.sh
utils/init-java.sh
utils/init-postgres.sh
utils/init-python.sh
```

# Additional setup (optional)

## Exercism
```
utils/init-exercism.sh
```

Then get token from: https://exercism.io/my/settings
```bash
exercism configure --token=${THE_TOKEN}
```

## Elm format-on-save in vscode
Ctrl+Shift+P, open settings (JSON), then add the following key:
```json
"[elm]": {
    "editor.formatOnSave": true
},
```

# Troubleshooting

## If linux localhost is unreachable from windows
Run the following in linux:
```bash
ip addr | grep eth0
```
then copy the ip after 'inet', it's the same ip displayed by elm-app start

## If pgAdmin cannot connect to postgresql
Run the following in powershell:
```powershell
wsl --shutdown
```

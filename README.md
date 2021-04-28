# Steps

## 1) Configure SSH for git
```bash
wget -qO init-git.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-git.sh && bash init-git.sh && source ~/.bashrc && rm init-git.sh
```

Add SSH key to github account: https://github.com/settings/ssh/new

## 2) Update and install dependency packages
```
echo yes | git clone git@github.com:AntoineSavage/utils.git && bash utils/init-packages.sh
```

## 3) Install specific components:

### docker
```bash
bash utils/init-docker.sh
```

### elixir
```bash
bash utils/init-elixir.sh
```

### elm
```bash
bash utils/init-elm.sh
```

### exercism
```bash
bash utils/init-exercism.sh
```

Then get token from: https://exercism.io/my/settings
```bash
exercism configure --token=${THE_TOKEN}
```

### haskell
```bash
bash utils/bash init-haskell.sh
```

### java
```bash
bash utils/init-java.sh
```

### postgresql
```bash
bash utils/init-postgres.sh
```

### python
```bash
bash utils/init-python.sh
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

## Elm format-on-save in vscode
Ctrl+Shift+P, open settings (JSON), then add the following key:
```json
"[elm]": {
    "editor.formatOnSave": true
},
```

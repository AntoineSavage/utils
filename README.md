# init-git
```bash
wget -qO init-git.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-git.sh && bash init-git.sh && source ~/.bashrc
```

# init-linux
```bash
wget -qO init-linux.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-linux.sh && bash init-linux.sh && source ~/.bashrc
```

Add SSH key to github account: https://github.com/settings/ssh/new

# Specific

Choose any among the following

## docker
```bash
wget -qO init-docker.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-docker.sh && bash init-docker.sh
```

## elixir
```bash
wget -qO init-elixir.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-elixir.sh && bash init-elixir.sh
```

## elm
```bash
wget -qO init-elm.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-elm.sh && bash init-elm.sh
```

## exercism
```bash
wget -qO init-exercism.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-exercism.sh && bash init-exercism.sh
```

Then get token from: https://exercism.io/my/settings
```bash
exercism configure --token=${THE_TOKEN}
```

## haskell
```bash
wget -qO init-haskell.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-haskell.sh && bash init-haskell.sh
```

## java
```bash
wget -qO init-java.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-java.sh && bash init-java.sh
```

## postgresql
```bash
wget -qO init-postgres.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-postgres.sh && bash init-postgres.sh
```

## python
```bash
wget -qO init-python.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-python.sh && bash init-python.sh
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

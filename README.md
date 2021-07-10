# WSL Ubuntu Setup

## 1) Main install

This will take about 25 mins:

```bash
wget -qO init.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init.sh && bash init.sh && rm init.sh
```

In the meantime...

## 2) Add SSH key to github account

Copy the output of the following command (in another terminal):

```bash
cat ~/.ssh/id_ed25519.pub
```

Into here: <https://github.com/settings/ssh/new>

## 3) Setup Exercism credentials

Then get token from: <https://exercism.io/my/settings>

Into here (new terminal):

```bash
exercism configure --token=${THE_TOKEN}
```

## 4) Start docker daemon

When main install is finished, log out then log back in:

```bash
sudo dockerd
```

## 5) Pre-compile haskell dependencies

When main install is finished. This will take about one hour:

```bash
wget -qO haskell-deps.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/haskell-deps.sh && bash haskell-deps.sh && rm haskell-deps.sh
```

## Local env

### Postgres + dvdrental

https://github.com/Dexels/postgres-debezium-dvdrental
TODO

## Troubleshooting

### If linux localhost is unreachable from windows

Run the following in linux:

```bash
ip addr | grep eth0
```

then copy the ip after 'inet', it's the same ip displayed by elm-app start

### If VSCode cannot connect to WSL

Run the following in linux:

```bash
code .
```

It will download the latest vscode wsl server. You can close the vscode afterwards

### If pgAdmin cannot connect to postgresql

Run the following in powershell:

```powershell
wsl --shutdown
```

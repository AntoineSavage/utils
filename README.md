# WSL Ubuntu Setup

## 1) Main install

This will take about 20 mins:

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

## Troubleshooting

### If linux localhost is unreachable from windows

Run the following in linux:

```bash
ip addr | grep eth0
```

then copy the ip after 'inet', it's the same ip displayed by elm-app start

### If pgAdmin cannot connect to postgresql

Run the following in powershell:

```powershell
wsl --shutdown
```

# WSL Ubuntu Setup

## 1) Main install

This will take about 25 mins:

```bash
wget -qO - https://raw.githubusercontent.com/AntoineSavage/utils/main/init.sh | bash
```

In the meantime...

## 2) Add SSH key to github account

Copy the output of the following command (in another terminal):

```bash
cat ~/.ssh/id_ed25519.pub
```

Into here: <https://github.com/settings/ssh/new>

## 3) Pre-compile haskell dependencies

When main install is finished. This will take about one hour:

```bash
wget -qO - https://raw.githubusercontent.com/AntoineSavage/utils/main/haskell-deps.sh | bash
```

## Troubleshooting

### If linux localhost is unreachable from windows

Run the following in linux:

```bash
ip addr | grep eth0
```

then copy the ip after 'inet', it's the same ip displayed by elm-app start

### If VSCode cannot connect to WSL

`Ctrl` + `Shift` + `P`, type `Remote-WSL: New WSL Window using Distro...`

Then, if the default is `docker-desktop-data`, you need to change the default back to ubuntu. You can also use the following (in windows):

```powershell
> wslconfig /l
Windows Subsystem for Linux Distributions:
docker-desktop-data (Default)
Ubuntu-20.04
docker-desktop
```

Run the following in powershell:

```powershell
wslconfig /setdefault Ubuntu-20.04
```

(And make sure to use the exact name, i.e. `Ubuntu-20.04` in the above example)


## ActiveState install

```bash
wget -qO - https://raw.githubusercontent.com/AntoineSavage/utils/main/init-activestate.sh | bash
```

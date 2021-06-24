# VSCode Extentions

## Export

In linux:

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```

In windows:

```powershell
code --list-extensions | % { "code --install-extension $_" }
```

### Import

In linux (taken from above bash command):

```bash
code --install-extension Extensions installed on WSL: Ubuntu-20.04:
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension donjayamanne.githistory
code --install-extension elmTooling.elm-ls-vscode
code --install-extension haskell.haskell
code --install-extension hbenl.vscode-test-explorer
code --install-extension justusadam.language-haskell
code --install-extension mhutchie.git-graph
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-vscode.test-adapter-converter
```

In windows (taken from above powershell command):

```powershell
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension justusadam.language-haskell
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-vscode-remote.remote-wsl
```

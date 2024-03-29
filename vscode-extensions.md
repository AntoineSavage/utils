# VSCode Extentions

## Elm format-on-save

Ctrl+Shift+P, open settings (JSON), then add the following key:

```json
"[elm]": {
    "editor.formatOnSave": true
},
```

## Export

In linux:

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```

You might have to run this in the vscode terminal if `code` is not on the PATH

In windows:

```powershell
code --list-extensions | % { "code --install-extension $_" }
```

### Import

In linux (taken from above bash command):

```bash
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension donjayamanne.githistory
code --install-extension elmTooling.elm-ls-vscode
code --install-extension haskell.haskell
code --install-extension justusadam.language-haskell
code --install-extension mhutchie.git-graph
```

You might have to run this in the vscode terminal if `code` is not on the PATH

In windows (taken from above powershell command):

```powershell
code --install-extension ms-vscode-remote.remote-wsl
```

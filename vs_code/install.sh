#!/bin/bash

echo "Installing vs code config"

cp keybindings.json ~/.config/Code/User/
cp settings.json ~/.config/Code/User/

code --install-extension vscodevim.vim
code --install-extension rust-lang.rust
code --install-extension ms-vscode.cpptools
code --install-extension Equinusocio.vsc-material-theme
code --install-extension PKief.material-icon-theme
code --install-extension bungcip.better-toml
code --install-extension foxundermoon.shell-format
code --install-extension truman.autocomplate-shell
code --install-extension formulahendry.code-runner
code --install-extension PeterJausovec.vscode-docker
code --install-extension ms-python.python

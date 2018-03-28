#!/bin/bash

echo "Installing vs code config"

cp keybindings.json ~/.config/Code/User/
cp settings.json ~/.config/Code/User/

code-oss --install-extension vscodevim.vim
code-oss --install-extension rust-lang.rust
code-oss --install-extension ms-vscode.cpptools
code-oss --install-extension Equinusocio.vsc-material-theme
code-oss --install-extension PKief.material-icon-theme
code-oss --install-extension bungcip.better-toml
code-oss --install-extension foxundermoon.shell-format
code-oss --install-extension truman.autocomplate-shell
code-oss --install-extension formulahendry.code-runner
code-oss --install-extension PeterJausovec.vscode-docker


#!/bin/bash

echo "Installing extensions"
# General
code --install-extension vscodevim.vim
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension PeterJausovec.vscode-docker
code --install-extension foxundermoon.shell-format
code --install-extension truman.autocomplate-shell
code --install-extension Equinusocio.vsc-material-theme
code --install-extension PKief.material-icon-theme

# Rust
code --install-extension rust-lang.rust
code --install-extension bungcip.better-toml

# Python
code --install-extension ms-python.python

# Java
code --install-extension vscjava.vscode-java-pack

echo "Installing Vs Code config"
cp keybindings.json ~/.config/Code/User/
cp settings.json ~/.config/Code/User/

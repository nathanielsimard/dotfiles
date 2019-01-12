#!/bin/bash

echo "Installing extensions"
# General
code --install-extension vscodevim.vim
code --install-extension eamodio.gitlens
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension PeterJausovec.vscode-docker
code --install-extension Equinusocio.vsc-material-theme
code --install-extension PKief.material-icon-theme

# Rust
code --install-extension rust-lang.rust
code --install-extension bungcip.better-toml

# Go
code --install-extension ms-vscode.Go

# Python
code --install-extension ms-python.python
code --install-extension njpwerner.autodocstring

echo "Installing Vs Code config"
cp keybindings.json ~/.config/Code/User/
cp settings.json ~/.config/Code/User/

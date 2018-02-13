#!/bin/bash

echo "Installing vs code config"

cp keybindings.json ~/.config/Code/User/
cp settings.json ~/.config/Code/User/

code --install-extension vscodevim.vim
code --install-extension rust-lang.rust
code --install-extension ms-vscode.cpptools
code --install-extension will-stone.plastic



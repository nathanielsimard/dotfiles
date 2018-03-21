#!/bin/bash

echo "Installing vs code config"

cp keybindings.json ~/.config/Code/User/
cp settings.json ~/.config/Code/User/

code-oss --install-extension vscodevim.vim
code-oss --install-extension rust-lang.rust
code-oss --install-extension ms-vscode.cpptools
code-oss --install-extension will-stone.plastic



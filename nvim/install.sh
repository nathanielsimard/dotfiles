#!/bin/sh

# Install Zathura Config for LaTex
mkdir -p ~/.config/zathura
cp zathurarc ~/.config/zathura/zathurarc

# Install Neovim Config
mkdir -p ~/.config/nvim
cp ./*.vim ~/.config/nvim/

# Install LSP Config
cp ./settings.json ~/.config/nvim/

# Install Editor Config
cp ./.editorconfig ~/

# Install Pydocstring Config
cp -r pydocstring-templates ~/.config/nvim

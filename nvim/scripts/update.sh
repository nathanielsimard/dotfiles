#!/bin/sh

# Install Zathura Config for LaTex
mkdir -p ~/.config/zathura
cp ./config/zathurarc ~/.config/zathura/zathurarc

# Install Neovim Config
mkdir -p ~/.config/nvim
cp ./*.vim ~/.config/nvim/

mkdir -p ~/.config/nvim/lang/
cp ./lang/*.vim ~/.config/nvim/lang/

mkdir -p ~/.config/nvim/utils/
cp ./utils/*.vim ~/.config/nvim/utils/

# Install Editor Config
cp ./config/.editorconfig ~/

nvim --headless -c 'PlugUpgrade|PlugUpdate|qa'

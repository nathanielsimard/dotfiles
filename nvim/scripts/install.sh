#!/bin/sh

# Install Zathura Config for LaTex
mkdir -p ~/.config/zathura
cp ./config/zathurarc ~/.config/zathura/zathurarc

# Install Neovim Config
mkdir -p ~/.config/nvim
cp ./*.vim ~/.config/nvim/
mkdir -p ~/.config/nvim/lang/
cp ./lang/*.vim ~/.config/nvim/lang/

# Install Editor Config
cp ./config/.editorconfig ~/

#!/bin/sh

# Install Neovim Config
mkdir -p ~/.config/nvim
cp ./*.vim ~/.config/nvim/

mkdir -p ~/.config/nvim/lang/
cp ./lang/*.vim ~/.config/nvim/lang/

mkdir -p ~/.config/nvim/utils/
cp ./utils/*.vim ~/.config/nvim/utils/

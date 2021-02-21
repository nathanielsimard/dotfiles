#!/bin/bash

# General
pip install neovim

# VimL
sudo npm install -g vim-language-server

# Javscript / Typescript
sudo npm install -g typescript-language-server typescript

# Python
sudo npm install -g pyright

# LaTex
pip install neovim-remote
wget https://github.com/latex-lsp/texlab/releases/download/v1.9.0/texlab-x86_64-linux.tar.gz
tar xvfz texlab-x86_64-linux.tar.gz
mv texlab ~/.local/bin/
rm texlab-x86_64-linux.tar.gz

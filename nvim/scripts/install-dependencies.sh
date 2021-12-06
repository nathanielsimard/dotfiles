#!/bin/bash

# General
pip install neovim

# VimL
npm install -g vim-language-server

# Linters
npm install -g diagnostic-languageserver

# Javascript / Typescript
npm install -g typescript-language-server typescript

# Python
npm install -g pyright

# Bash / Sh
npm install -g bash-language-server

# LaTex
pip install neovim-remote
wget https://github.com/latex-lsp/texlab/releases/download/v1.9.0/texlab-x86_64-linux.tar.gz
tar xvfz texlab-x86_64-linux.tar.gz
mv texlab ~/.local/bin/
rm texlab-x86_64-linux.tar.gz

#!/bin/sh

wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim-nightly

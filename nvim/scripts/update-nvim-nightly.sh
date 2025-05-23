#!/bin/sh

wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage ~/.local/bin/nvim-nightly

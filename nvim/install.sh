#!/bin/sh

mkdir -p ~/.config/nvim

cp ./*.vim ~/.config/nvim/
cp -r syntax/*.vim ~/.config/nvim/syntax

cp ./.editorconfig ~/

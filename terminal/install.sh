#!/bin/bash

echo "Installing bash config"

wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
mv git-prompt.sh ~/.git-prompt.sh

if [ -e ~/.bashrc ]; then
	mkdir -p ~/.config.old
	mv ~/.bashrc ~/.config.old/
fi

cp .bashrc ~/
cp .inputrc ~/
touch ~/.python_env

if [ -e ~/.bash_profile ]; then
	mkdir -p ~/.config.old
	mv ~/.bash_profile ~/.config.old/
fi

cp .bash_profile ~/

# Add Npm Completion
touch ~/.npm-completion.sh
if [ -e "$(command -v npm)" ]; then
    npm completion >> ~/.npm-completion.sh
fi

mkdir -p ~/.config
mkdir -p ~/.config/alacritty

cp alacritty.yml ~/.config/alacritty

echo "Installing Fonts"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip
mkdir -p ~/.local/share
mkdir -p ~/.local/share/fonts
mv FiraCode ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/

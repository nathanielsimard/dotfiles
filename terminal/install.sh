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

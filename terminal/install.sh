#!/bin/bash

echo "Installing bash config"

wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
mv git-prompt.sh ~/.git-prompt.sh

if [ -e ~/.bashrc ]; then
	mkdir -p ~/.config.old
	mv ~/.bashrc ~/.config.old/
fi

cp .bashrc ~/

if [ -e ~/.bash_profile ]; then
	mkdir -p ~/.config.old
	mv ~/.bash_profile ~/.config.old/
fi

cp .bash_profile ~/

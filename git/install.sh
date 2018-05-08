#!/bin/bash

echo "Installing git config"

if [ -e ~/.gitconfig ]; then
	mkdir -p ~/.config.old
	mv ~/.gitconfig ~/.config.old/
fi

cp .gitconfig ~/

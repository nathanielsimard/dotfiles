#!/bin/bash

echo "Installing jetbrain vim config"

if [ -e ~/.ideavimrc ]; then
	mkdir -p ~/.config.old
	mv ~/.ideavimrc ~/.config.old
fi

cp .ideavimrc ~/

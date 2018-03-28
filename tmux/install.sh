#!/bin/bash

echo "Installing tmux config"

if [ -e ~/.tmux.conf ]; then
	mkdir -p ~/.config.old
	mv ~/.tmux.conf ~/.config.old/
fi

cp .tmux.conf ~/

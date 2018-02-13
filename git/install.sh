#!/bin/bash

echo "Installing git config"

if [ -e ~/.gitconfig ]
then
    mkdir -p ~/.config.old
    mv ~/.gitconfig ~/.config.old/
fi

cp .gitconfig ~/

echo "What is your name ?"
read name

echo "What is your email ?"
read email

git config --global user.name "$name"
git config --global user.email "$email"
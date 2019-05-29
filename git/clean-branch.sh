#! /bin/sh

# Usage: git-clear-branches
# Description: Force delete all gone branches

git branch -v | grep gone | awk '{ print $1 }' | xargs git branch -D


#!/bin/bash

mkdir -p ~/.local/bin/
wget https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz
mv ~/.local/bin/rust-analyzer ~/.local/bin/rust-analyzer.old
gunzip -c rust-analyzer-x86_64-unknown-linux-gnu.gz > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
rm rust-analyzer-x86_64-unknown-linux-gnu.gz

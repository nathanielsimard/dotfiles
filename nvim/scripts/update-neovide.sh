wget https://github.com/neovide/neovide/releases/latest/download/neovide.tar.gz
tar xvfz neovide.tar.gz
mv ~/.local/bin/neovide ~/.local/bin/neovide.old
chmod +x neovide
mv neovide ~/.local/bin/neovide
rm neovide.tar.gz

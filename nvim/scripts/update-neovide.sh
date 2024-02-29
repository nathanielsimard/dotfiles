wget https://github.com/neovide/neovide/releases/latest/download/neovide-linux-x86_64.tar.gz
tar xvfz neovide-linux-x86_64.tar.gz
mv ~/.local/bin/neovide ~/.local/bin/neovide.old
chmod +x neovide
mv neovide ~/.local/bin/neovide
rm neovide-linux-x86_64.tar.gz


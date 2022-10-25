wget https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
mkdir jdt-language-server-latest
tar xvfz jdt-language-server-latest.tar.gz -C jdt-language-server-latest
mv jdt-language-server-latest ~/.local/share/jdt-language-server-latest
ln -s ~/.local/share/jdt-language-server-latest/bin/jdtls ~/.local/bin/jdtls
rm jdt-language-server-latest.tar.gz

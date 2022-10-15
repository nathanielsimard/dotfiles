wget https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
tar xvfz jdt-language-server-latest.tar.gz
mv ~/.local/bin/jdt-language-server-latest ~/.local/bin/jdt-language-server-latest.old
mv jdt-language-server-latest ~/.local/bin/jdt-language-server-latest
rm jdt-language-server-latest.tar.gz

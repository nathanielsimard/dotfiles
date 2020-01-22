#!/bin/bash

echo "clone https://github.com/Microsoft/python-language-server into ~/.local/share"

cd ~/.local/share/python-language-server/src/LanguageServer/Impl
git pull
dotnet-sdk.dotnet publish -c Release -r linux-x64

ln -s ~/.local/share/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer ~/.local/bin/ms-pyls 

#!/usr/bin/env bash

#echo "Installing basic software"
#sudo apt install plymouth-theme-ubuntu-gnome-logo \
#                 gnome-session \
#                 neofetch \
#                 docker.io \
#                 docker-compose \
#                 chrome-gnome-shell \
#                 gnome-tweaks \
#                 htop 
#
sudo update-alternatives --config gdm3.css
sudo update-alternatives --config default.plymouth

#echo "Setup docker group"
#sudo groupadd docker
#sudo gpasswd -a $USER docker
#
#echo ""
#echo "Unsupported softwares on this computer:"
#echo "---------------------------------------"
#ubuntu-support-status --show-unsupported

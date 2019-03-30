#!/bin/bash

echo "Update"
sudo dnf update -y

echo "Adding Visual Studio Code repositoty"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update -y
sudo dnf install -y code

echo "Enable RpmFusion"
sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Enable Dot Net Core"
sudo dnf copr -y enable @dotnet-sig/dotnet

echo "Enable Themes"
sudo dnf copr -y enable tcg/themes

echo "Enable Flathub"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing codecs"
sudo dnf install -y \
    gstreamer-plugins-bad \
    gstreamer-plugins-bad-free-extras \
    gstreamer-plugins-bad-nonfree \
    gstreamer-plugins-ugly \
    gstreamer-ffmpeg \
    gstreamer1-libav \
    gstreamer1-plugins-bad-free-extras \
    gstreamer1-plugins-bad-freeworld \
    gstreamer1-plugins-base-tools \
    gstreamer1-plugins-good-extras \
    gstreamer1-plugins-ugly \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-good \
    gstreamer1-plugins-base \
    gstreamer1 \
    x264

echo "Installing basic software"
sudo dnf install -y \
    neofetch \
    materia-theme \
    code \
    guake \
    gnome-shell-extension-pomodoro \
    htop \
    neovim \
    chrome-gnome-shell \
    dotnet \
    docker \
    docker-compose \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel \
    gnome-tweak-tool

echo "Setup docker group"
sudo groupadd docker
sudo gpasswd -a $USER docker

echo "Installing basic flatpak"
flatpak install -y flathub \
    com.spotify.Client \
    com.valvesoftware.Steam \
    com.slack.Slack

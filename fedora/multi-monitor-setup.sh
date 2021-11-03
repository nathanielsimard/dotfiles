#!/bin/bash

gsettings set org.gnome.desktop.interface scaling-factor 2
xrandr  \
    --output HDMI-0  --mode 3840x2160 --pos 0x0    --scale 1.5x1.5 --primary \
    --output eDP-1-1 --mode 1920x1080 --pos 5760x0 --scale 2x2

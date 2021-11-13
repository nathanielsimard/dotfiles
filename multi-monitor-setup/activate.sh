#!/bin/bash

gsettings set org.gnome.desktop.interface scaling-factor 2
gsettings set org.gnome.desktop.interface text-scaling-factor 1.10

xrandr  \
    --output eDP-1-1 --mode 1920x1080 --pos 0x0    --scale 2.15x2.15 \
    --output HDMI-0  --mode 3840x2160 --pos 4128x0 --scale 1.65x1.65 --primary #2.15 * 1920

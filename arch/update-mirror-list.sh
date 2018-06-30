#!/bin/sh 

curl -s "https://www.archlinux.org/mirrorlist/?country=CA&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > tmp

echo "----------------------------------------------"
echo "--------------------Mirors--------------------"
echo ""
cat tmp
sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
sudo mv tmp /etc/pacman.d/mirrorlist
echo ""
echo "Done"

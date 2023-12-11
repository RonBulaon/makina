#!/bin/bash

# Optimize Mirrors
sudo sh -c "pacman -S --noconfirm && pacman -S pacman-contrib --noconfirm && cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist"

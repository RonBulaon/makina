#!/bin/bash

export QT_QPA_PLATFORMTHEME=qt5ct
xrandr --output "Virtual-1" --mode "1920x1080"
~/.config/polybar/launch.sh --material &
picom --config ~/.config/picom/picom.conf &
wal -R


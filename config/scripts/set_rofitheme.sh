#!/bin/bash

# Path to the Xresources file
XRESOURCES="$HOME/.Xresources"

# Function to extract the first occurrence of a pattern
extract_color() {
    grep "$1" $XRESOURCES | head -n 1 | awk '{print $2}'
}

# Read colors from .Xresources
background=$(extract_color '*color0:')
foreground=$(extract_color '*color7:')
selected=$(extract_color '*color12:')   # Example: using color12 for selected
active=$(extract_color '*color13:')     # Example: using color13 for active
urgent=$(extract_color '*color10:')     # Example: using color10 for urgent

# Create or overwrite the onedark.rasi file
cat << EOF > $HOME/.config/rofi/colors/onedark.rasi
* {
    background:     $background;
    background-alt: $background;  
    foreground:     $foreground;
    selected:       $selected;
    active:         $active;
    urgent:         $urgent;
}
EOF

echo "onedark.rasi file has been generated."


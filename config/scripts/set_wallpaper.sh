#!/bin/bash

# Check if the user provided a PNG file path as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <path_to_file>"
  exit 1
fi

# Extract the file path from the command line argument
image_path="$1"

# Check if the file exists
if [ ! -f "$image_path" ]; then
  echo "Error: The specified file does not exist."
  exit 1
fi

# Use the `file` command to check if the file is an image
if ! file -b "$image_path" | grep -i image; then
  echo "Error: The specified file is not an image."
  exit 1
fi

# Execute the 'wal' command with the provided PNG file
wal -i "$image_path"
~/.config/scripts/set_rofitheme.sh
~/.config/polybar/material/scripts/pywal.sh "$image_path"
awesome-client 'awesome.restart()'


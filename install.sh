#!/bin/bash

if [ -d "config" ]; then
  mydotfiles="$(pwd)/config"
  echo "Found 'config' folder at $mydotfiles"
else
  echo "No 'config' folder found in the current directory."
  exit
fi

if [ -d "local" ]; then
  mylocalfiles="$(pwd)/local"
  echo "Found 'local' folder at $mylocalfiles"
else
  echo "No 'config' folder found in the current directory."
  exit
fi

if [ -d "wallpaper" ]; then
  mywallpaper="$(pwd)/wallpaper"
  echo "Found 'wallpaper' folder at $mywallpaper"
else
  echo "No 'wallpaper' folder found in the current directory."
  exit
fi

# Dell HW Issue
sudo sh -c 'echo "options i915 modeset=1 enable_rc6=1 enable_fbc=1 enable_guc_loading=1 enable_guc_submission=1 enable_huc=1 enable_psr=1 disable_power_well=0" > /etc/modprobe.d/i915.conf'

# Update
sudo sh -c "pacman -Sy"

# Install python-pywal
sudo sh -c "pacman -S --noconfirm python-pywal"

# SSH
sudo pacman -S openssh && sudo systemctl start sshd && sudo systemctl enable sshd

# Scripts
echo "Making scripts executable"
chmod +x $mydotfiles/scripts/startup.sh
chmod +x $mydotfiles/scripts/set_wallpaper.sh
chmod +x $mydotfiles/scripts/set_rofitheme.sh
chmod +x $mydotfiles/rofi/launchers/type-1/launcher.sh 
chmod +x $mydotfiles/polybar/launch.sh

# Optimize Mirrors
sudo sh -c "pacman -S --noconfirm && pacman -S pacman-contrib --noconfirm && cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist"

# Install Yay
sudo pacman -S --needed --noconfirm base-devel git && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm

# Install Awesome
sudo sh -c "pacman -S --noconfirm alacritty ttf-jetbrains-mono-nerd xdg-user-dirs nitrogen font-manager ttf-font-awesome rofi polybar dolphin qt5ct picom tmux neofetch neovim"

# Required files and folders
xdg-user-dirs-update 
fc-cache -f -v 

# Starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Link config files
mkdir ~/.config
ln -s $mydotfiles/alacritty ~/.config
ln -s $mydotfiles/awesome ~/.config
ln -s $mydotfiles/kde.org ~/.config
ln -s $mydotfiles/neofetch ~/.config
ln -s $mydotfiles/picom ~/.config
ln -s $mydotfiles/polybar ~/.config
ln -s $mydotfiles/qt5ct ~/.config
ln -s $mydotfiles/rofi ~/.config
ln -s $mydotfiles/scripts ~/.config
ln -s $mydotfiles/tmux ~/.config
ln -s $mydotfiles/wal ~/.config
ln -s $mydotfiles/dolphinrc ~/.config
ln -s $mydotfiles/kconf_updaterc ~/.config
ln -s $mydotfiles/kdeglobals ~/.config
ln -s $mydotfiles/starship.toml ~/.config
ln -s $mydotfiles/scripts/set_wallpaper.sh $mydotfiles/scripts

# Link local files
mkdir ~/.local
ln -s $mylocalfiles/share/dolphin ~/.local/share
ln -s $mylocalfiles/share/fonts ~/.local/share

# Link bash files
mv ~/.bashrc ~/.bashrc.old
mv ~/.bash_logout ~/.bash_logout.old
mv ~/.bash_profile ~/.bash_profile.old
mv ~/.xinitrc ~/.xinitrc.old
ln -s $mydotfiles/bash/bashrc ~/.bashrc
ln -s $mydotfiles/bash/bash_logout ~/.bash_logout
ln -s $mydotfiles/bash/bash_profile ~/.bash_profile
ln -s $mydotfiles/bash/xinitrc ~/.xinitrc
source ~/.bashrc 
source ~/.bash_profile 

# Link wallpapers
ln -s $mywallpaper ~/Pictures/

# Wall paper and theme
wal -i ~/Pictures/wallpaper/samurai.png
ln -sf ~/.cache/wal/colors.Xresources ~/.Xresources

# exit awesome
while true; do
    clear
    echo "Choose an option:"
    echo "1. Log Off"
    echo "2. Restart"
    echo "3. Quit Script"

    read -p "Enter your choice: " choice

    case $choice in
        1)
            echo "Logging off..."
            awesome-client 'awesome.quit()'
            ;;
        2)
            echo "Restarting..."
            reboot
            ;;
        3)
            echo "Quitting the script."reboot
            awesome-client 'awesome.restart()'
            exit
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, or 3."
            ;;
    esac

    # Pause before returning to the menu
    read -n 1 -s -r -p "Press any key to continue..."
done


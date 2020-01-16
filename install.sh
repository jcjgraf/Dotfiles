#!/bin/bash
# Symlinkes dotfiles to correct location

dotfiles=~/Dotfiles

linker() {
    # Symlinks file $1 to destination $2
    ## Caution: destination $2 gets removes!

    sudo rm -rf $2 > /dev/null 2>&1
    ln -sf $1 $2
}

# Link Files
## System
linker "$dotfiles/zsh/.zshrc" ~/.zshrc
linker "$dotfiles/termite" ~/.config/termite
linker "$dotfiles/.Xresources" ~/.Xresources
linker "$dotfiles/gtk-3.0" ~/.config/gtk-3.0
linker "$dotfiles/.gtkrc-2.0" ~/.gtkrc-2.0
linker "$dotfiles/fontconfig" ~/.config/fontconfig
linker "$dotfiles/mimeapps.list" ~/.config/mimeapps.list
linker "$dotfiles/locale.conf" ~/.config/locale.conf
linker "$dotfiles/Scripts/lock.sh" ~/bin/lock.sh
sudo bash -c "$(declare -f linker); linker \"$dotfiles/acpi\" '/etc/acpi'" # Run as root

## WM
linker "$dotfiles/wm/i3" ~/.config/i3
linker "$dotfiles/wm/i3blocks" ~/.config/i3blocks
linker "$dotfiles/wm/i3scripts" ~/.config/i3scripts

## Applications
linker "$dotfiles/.vimrc" ~/.vimrc
linker "$dotfiles/redshift" ~/.config/redshift
linker "$dotfiles/.gitconfig" ~/.gitconfig
linker "$dotfiles/dunst" ~/.config/dunst
linker "$dotfiles/mpv" ~/.config/mpv

## Mail
linker "$dotfiles/Mail/mutt" ~/.config/mutt
linker "$dotfiles/Mail/msmtp" ~/.config/msmtp
linker "$dotfiles/Mail/.mbsyncrc" ~/.mbsyncrc

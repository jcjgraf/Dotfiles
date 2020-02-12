#!/bin/bash
# Symlinkes dotfiles to correct location

dotfiles=~/Dotfiles

linker() {
    # Symlinks file $1 to destination $2
    ## Caution: destination $2 gets removed!

    sudo rm -rf "$2" > /dev/null 2>&1
    ln -sf "$1" "$2"
}

colorizer() {
    # Replaces color placeholders in $1 and copies it to $2
    ## Caution: desitnation $2 gets removed!

    local dir="$(dirname $2)"

    sudo rm -rf "$dir" > /dev/null 2>&1
    mkdir -p "$dir"
    sh $dotfiles/colorizer.sh "$1" "$2"
}

# Process Files
## System
linker "$dotfiles/zsh/.zshrc" ~/.zshrc
linker "$dotfiles/zsh/alias.zsh" ~/.oh-my-zsh/custom/alias.zsh
linker "$dotfiles/zsh/jc.zsh-theme" ~/.oh-my-zsh/custom/themes/jc.zsh-theme
linker "$dotfiles/.xcolors" ~/.xcolors
linker "$dotfiles/.Xresources" ~/.Xresources
xrdb ~/.Xresources
linker "$dotfiles/gtk-3.0" ~/.config/gtk-3.0
linker "$dotfiles/.gtkrc-2.0" ~/.gtkrc-2.0
linker "$dotfiles/fontconfig" ~/.config/fontconfig
linker "$dotfiles/mimeapps.list" ~/.config/mimeapps.list
linker "$dotfiles/locale.conf" ~/.config/locale.conf
sudo bash -c "$(declare -f linker); linker \"$dotfiles/acpi\" '/etc/acpi'" # Run as root
linker "$dotfiles/systemd" ~/.config/systemd

## Scripts
linker "$dotfiles/Scripts/notifier" ~/bin/notifier
linker "$dotfiles/Scripts/lock.sh" ~/bin/lock.sh
linker "$dotfiles/Scripts/battery.sh" ~/bin/battery.sh
linker "$dotfiles/Scripts/mailChecker.sh" ~/bin/mailChecker.sh
linker "$dotfiles/Scripts/monitor.sh" ~/bin/monitor.sh

## WM
linker "$dotfiles/wm/i3" ~/.config/i3
linker "$dotfiles/wm/i3blocks" ~/.config/i3blocks
linker "$dotfiles/wm/i3scripts" ~/.config/i3scripts

## Applications
linker "$dotfiles/.vimrc" ~/.vimrc
mkdir -p ~/.vim/undo/ ~/.vim/backup/ ~/.vim/swap/
linker "$dotfiles/redshift" ~/.config/redshift
linker "$dotfiles/.gitconfig" ~/.gitconfig
colorizer "$dotfiles/dunst/dunstrc.raw" ~/.config/dunst/dunstrc
linker "$dotfiles/mpv" ~/.config/mpv
colorizer "$dotfiles/termite/config.raw" ~/.config/termite/config

## Mail
linker "$dotfiles/Mail/mutt" ~/.config/mutt
linker "$dotfiles/Mail/msmtp" ~/.config/msmtp
linker "$dotfiles/Mail/.mbsyncrc" ~/.mbsyncrc

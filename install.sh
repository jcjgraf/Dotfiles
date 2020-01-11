#!/bin/bash

# Variables
dotfiles="$HOME"/Dotfiles

# Delete existing dotfiles
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.config/i3 > /dev/null 2>&1
sudo rm -rf ~/.config/i3blocks > /dev/null 2>&1
sudo rm -rf ~/.config/i3scripts > /dev/null 2>&1
sudo rm -rf ~/.config/termite > /dev/null 2>&1
sudo rm -rf ~/.config/.Xresources > /dev/null 2>&1
sudo rm -rf "~/.config/gtk-3.0" > /dev/null 2>&1
sudo rm -rf "~/.gtkrc-2.0" > /dev/null 2>&1
sudo rm -rf ~/.config/fontconfig > /dev/null 2>&1
sudo rm -rf ~/.config/mimeapps.list > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.config/redshift > /dev/null 2>&1
sudo rm -rf /etc/acpi > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -rf ~/bin/lock.sh > /dev/null 2>&1
sudo rm -rf ~/.config/dunst > /dev/null 2>&1
sudo rm -rf ~/.config/locale.conf > /dev/null 2>&1
sudo rm -rf ~/.config/mpv > /dev/null 2>&1


# Create symlink
ln -sf "$dotfiles/zsh/.zshrc" ~/.zshrc
ln -sf "$dotfiles/wm/i3" ~/.config/i3
ln -sf "$dotfiles/wm/i3blocks" ~/.config/i3blocks
ln -sf "$dotfiles/wm/i3scripts" ~/.config/i3scripts
ln -sf "$dotfiles/termite" ~/.config
ln -sf "$dotfiles/.Xresources" ~/
ln -sf "$dotfiles/gtk-3.0" ~/.config
ln -sf "$dotfiles/.gtkrc-2.0" ~/
ln -sf "$dotfiles/fontconfig" ~/.config
ln -sf "$dotfiles/mimeapps.list" ~/.config
ln -sf "$dotfiles/.vimrc" ~/
ln -sf "$dotfiles/redshift" ~/.config
sudo ln -sf $dotfiles/acpi /etc/acpi
ln -sf "$dotfiles/.gitconfig" ~/
ln -sf "$dotfiles/Scripts/lock.sh" ~/bin/lock.sh
ln -sf "$dotfiles/dunst" ~/.config/dunst
ln -sf "$dotfiles/locale.conf" ~/.config/locale.conf
ln -sf "$dotfiles/mpv" ~/.config/mpv


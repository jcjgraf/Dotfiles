#!/bin/bash
# Symlinkes dotfiles to correct location

dotfiles=~/Dotfiles

mail=false
calendar=false
shell=false
scripts=false
wm=false
xWin=false
vim=false
system=false
systemd=false
git=false
app=false
homeServer=false

linker() {
    # Symlinks file $1 to destination $2
    ## Caution: destination $2 gets removed!
	echo "Link {$1} to {$2}"
    sudo rm -rf "$2" > /dev/null 2>&1
    ln -sf "$1" "$2"
}

dirContentLinker() {
    # Symlinks files in $1 to destination $2
    if [[ -d $1 ]]
    then
        for file in ${1}*
        do
    	echo "Link {$file} to {$2}"
            ln -sf "$file" "$2"
        done
    fi
}

colorizer() {
    # Replaces color placeholders in $1 and copies it to $2
    ## Caution: desitnation $2 gets removed!

    local dir="$(dirname $2)"

    sudo rm -rf "$dir" > /dev/null 2>&1
    mkdir -p "$dir"
    sh $dotfiles/colorizer.sh "$1" "$2"
}

usage() {
    printf "Usage : $0\n-p PC mode\n-s Server mode\n-h Help"
}

if [[ $# -eq 0 ]]
then
    usage
    exit 1
fi

while getopts 'hsp' flag
do
    case "${flag}" in
        p)
            # PC
            mail=true
            calendar=true
            shell=true
            scripts=true
            wm=true
            xWin=true
            vim=true
            system=true
            systemd=true
            git=true
            app=true
            ;;
        s)
            # Server
            shell=true
            vim=true
            git=true
            homeServer=true
            ;;
        h | *)
            usage
            exit 1
            ;;
    esac
done

# Process Files
## System
### Shell
if [[ "$shell" = true ]]
then
    linker "$dotfiles/zsh/.zshrc" ~/.zshrc
    linker "$dotfiles/zsh/alias.zsh" ~/.oh-my-zsh/custom/alias.zsh
    linker "$dotfiles/zsh/jc.zsh-theme" ~/.oh-my-zsh/custom/themes/jc.zsh-theme
fi

### X
if [[ "$xWin" = true ]]
then
    linker "$dotfiles/.xcolors" ~/.xcolors
    linker "$dotfiles/zsh/.zlogin" ~/.zlogin
    linker "$dotfiles/.xinitrc" ~/.xinitrc
    linker "$dotfiles/.Xresources" ~/.Xresources
    xrdb ~/.Xresources

    linker "$dotfiles/gtk-3.0" ~/.config/gtk-3.0
    linker "$dotfiles/.gtkrc-2.0" ~/.gtkrc-2.0
fi

### System Configs
if [[ "$system" = true ]]
then
    linker "$dotfiles/fontconfig" ~/.config/fontconfig
    linker "$dotfiles/mimeapps.list" ~/.config/mimeapps.list
    linker "$dotfiles/locale.conf" ~/.config/locale.conf
fi

if [[ "$systemd" = true ]]
then
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/acpi\" '/etc/acpi'" # Run as root
    linker "$dotfiles/systemd" ~/.config/systemd
    linker "$dotfiles/.pam_environment" ~/.config/.pam_environment
fi

if [[ "$homeServer" = true ]]
then
    mkdir -p ~/HomeServer
    dirContentLinker "$dotfiles/HomeServer/" ~/HomeServer
fi

## Scripts
if [[ "$scripts" = true ]]
then
    linker "$dotfiles/Scripts/displayer" ~/bin/displayer
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/Scripts/displayer\" '/bin/displayer'"
    linker "$dotfiles/Scripts/lock.sh" ~/bin/lock.sh
    linker "$dotfiles/Scripts/battery.sh" ~/bin/battery.sh
    linker "$dotfiles/Scripts/mailChecker.sh" ~/bin/mailChecker.sh
    linker "$dotfiles/Scripts/monitor.sh" ~/bin/monitor.sh
    linker "$dotfiles/Scripts/screenRotation.sh" ~/bin/screenRotation.sh
    linker "$dotfiles/Scripts/backlight.sh" ~/bin/backlight.sh
    linker "$dotfiles/Scripts/note" ~/bin/note
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/Scripts/backlight.sh\" '/bin/backlight.sh'"
    linker "$dotfiles/Scripts/volume.sh" ~/bin/volume.sh
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/Scripts/volume.sh\" '/bin/volume.sh'"
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/Scripts/scrotMenu.sh\" '/bin/scrotMenu.sh'"
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/Scripts/monitorMenu.sh\" '/bin/monitorMenu.sh'"
fi

## WM
if [[ "$wm" = true ]]
then
    linker "$dotfiles/wm/i3" ~/.config/i3
    linker "$dotfiles/wm/i3blocks" ~/.config/i3blocks
    linker "$dotfiles/wm/i3scripts" ~/.config/i3scripts
fi

## Applications
### VIM
if [[ "$vim" = true ]]
then
    #mkdir -p ~/.vim/undo/ ~/.vim/backup/ ~/.vim/swap/
    mkdir -p ~/.config/nvim/autoload
    linker "$dotfiles/Vim/init.vim" ~/.config/nvim/init.vim
    linker "$dotfiles/Vim/General" ~/.config/nvim/General
    linker "$dotfiles/Vim/PluginConfig" ~/.config/nvim/PluginConfig
    linker "$dotfiles/Vim/autoload" ~/.config/nvim/autoload
    linker "$dotfiles/Vim/UltiSnips" ~/.config/nvim/UltiSnips
fi

### Git
if [[ "$git" = true ]]
then
    linker "$dotfiles/Git/config" ~/.config/git/config
    linker "$dotfiles/Git/gitignore_global" ~/.config/git/gitignore_global
fi

### Other Applications
if [[ "$app" = true ]]
then
    linker "$dotfiles/redshift" ~/.config/redshift
    colorizer "$dotfiles/dunst/dunstrc.raw" ~/.config/dunst/dunstrc
    linker "$dotfiles/mpv" ~/.config/mpv
    colorizer "$dotfiles/termite/config.raw" ~/.config/termite/config
    linker "$dotfiles/qutebrowser/config.py" ~/.config/qutebrowser/config.py
    linker "$dotfiles/Firefox/Tridactyl" ~/.config/tridactyl
    linker "$dotfiles/Firefox/user.js" ~/.mozilla/firefox/8bfetgg9.Main/user.js
    linker "$dotfiles/Vimiv/vimiv.conf" ~/.config/vimiv/vimiv.conf
    linker "$dotfiles/Vimiv/keys.conf" ~/.config/vimiv/keys.conf
    linker "$dotfiles/Newsboat" ~/.config/newsboat
    linker "$dotfiles/Rofi" ~/.config/rofi
    linker "$dotfiles/Wget/config" ~/.config/wget/config
fi

## Mail
if [[ "$mail" = true ]]
then
    linker "$dotfiles/Mail/mutt" ~/.config/mutt
    linker "$dotfiles/Mail/msmtp" ~/.config/msmtp
    linker "$dotfiles/Mail/.mbsyncrc" ~/.mbsyncrc
fi

## Calendar
if [[ "$calendar" = true ]]
then
    linker "$dotfiles/Calendar/Khal" ~/.config/khal
    linker "$dotfiles/Calendar/VdirSyncer" ~/.config/vdirsyncer
    linker "$dotfiles/Todoman" ~/.config/todoman
    linker "$dotfiles/Khard" ~/.config/khard
fi

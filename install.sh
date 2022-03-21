#!/bin/bash
# Symlinkes dotfiles to correct location

if [ $(id -u) = 0 ]
    then echo "Please do not run this script as root!"
    exit
fi

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

	echo "Color Link {$1} to {$2}"
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
    mkdir -p ~/.config/zsh
    linker "$dotfiles/zsh/.zshrc" ~/.config/zsh/.zshrc
    linker "$dotfiles/zsh/.zlogin" ~/.config/zsh/.zlogin
    linker "$dotfiles/zsh/.zprofile" ~/.config/zsh/.zprofile
    linker "$dotfiles/zsh/alias.zsh" ~/.config/zsh/alias.zsh
    linker "$dotfiles/zsh/prompt.zsh" ~/.config/zsh/prompt.zsh
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/zsh/zshenv\" '/etc/zsh/zshenv'" # Run as root
fi

### X
if [[ "$xWin" = true ]]
then
    linker "$dotfiles/X11/Xresources" ~/.config/X11/Xresources
    linker "$dotfiles/X11/xcolors" ~/.config/X11/xcolors
    linker "$dotfiles/X11/xinitrc" ~/.config/X11/xinitrc
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/X11/00-keyboard.conf\" /etc/X11/xorg.conf.d/00-keyboard.conf"
    sudo bash -c "$(declare -f linker); linker \"$dotfiles/X11/40-mouse-sensitivity.conf\" /etc/X11/xorg.conf.d/40-mouse-sensitivity.conf"
    xrdb ~/.config/X11/Xresources

    linker "$dotfiles/gtk-3.0" ~/.config/gtk-3.0
    linker "$dotfiles/gtk-2.0" ~/.config/gtk-2.0
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
    linker "$dotfiles/rsync_tmbackup/exclude_list" ~/.local/share/rsync_tmbackup/exclude_list
    linker "$dotfiles/.pam_environment" ~/.pam_environment
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
    linker "$dotfiles/Scripts/wwan.sh" ~/bin/wwan.sh
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
    linker "$dotfiles/Vimiv/vimiv.conf" ~/.config/vimiv/vimiv.conf
    linker "$dotfiles/Vimiv/keys.conf" ~/.config/vimiv/keys.conf
    linker "$dotfiles/Newsboat" ~/.config/newsboat
    linker "$dotfiles/Rofi" ~/.config/rofi
    linker "$dotfiles/Wget" ~/.config/wget
    linker "$dotfiles/Gnupg/gpg-agent.conf" ~/.gnupg/gpg-agent.conf
    linker "$dotfiles/Taskwarrior/taskrc" ~/.config/taskwarrior/taskrc
    linker "$dotfiles/Taskwarrior/dark-16.theme" ~/.config/taskwarrior/dark-16.theme
    linker "$dotfiles/Taskwarrior/on-modify.timewarrior" ~/.local/share/taskwarrior/hooks/on-modify.timewarrior
    linker "$dotfiles/Timewarrior/timewarrior.cfg" ~/.config/timewarrior/timewarrior.cfg
    linker "$dotfiles/Timewarrior/dark.theme" ~/.config/timewarrior/dark.theme
    linker "$dotfiles/Cabal/config" ~/.cabal/config
    linker "$dotfiles/gdb" ~/.config/gdb
fi

## Mail
if [[ "$mail" = true ]]
then
    linker "$dotfiles/Mail/mutt" ~/.config/mutt
    linker "$dotfiles/Mail/msmtp" ~/.config/msmtp
    mkdir -p "$HOME/.config/isync"
    linker "$dotfiles/Mail/.mbsyncrc" ~/.config/isync/mbsyncrc
fi

## Calendar
if [[ "$calendar" = true ]]
then
    linker "$dotfiles/Calendar/Khal" ~/.config/khal
    linker "$dotfiles/Calendar/VdirSyncer" ~/.config/vdirsyncer
    linker "$dotfiles/Todoman" ~/.config/todoman
    linker "$dotfiles/Khard" ~/.config/khard
fi

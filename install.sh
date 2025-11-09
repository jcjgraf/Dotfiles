#!/usr/bin/env bash

# Install the dotfiles on a node.

set -u
set -e
set -o pipefail

exec 3>&1

LONGOPTS="verbose,help"
OPTIONS=vh

function usage() {
    echo "Usage: $0 [OPTION]..."
    echo ""
    echo "Options:"
    echo "  --verbose, -v  Verbose logging."
    echo "  --help, -h     Show this help message"
    echo ""
}

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config/}"

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

function log_debug() {
    if [ "$verbose" = true ]; then
        printf "${BLUE}[DEBUG]${RESET} %s\n" "$*" 1>&3
    fi
}

function log_info() {
    printf "${GREEN}[INFO]${RESET} %b\n" "$*" 1>&3
}

function log_err() {
    printf "${RED}[ERROR]${RESET} %s\n" "$*" >&2
}

function log_err_msg() {
    log_err $@
    notify-send -u critical "APP ERROR" "$*\n"
}

function do_confirm() {
    read -p "Continue? [y/N] " -r
    [[ $REPLY =~ ^[Yy]$ ]]
}

if [ $(id -u) = 0 ]; then
    log_err "Please do not run this script as root."
    exit
fi

PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@") || exit 2
eval set -- "$PARSED"

verbose=false

while true; do
    case "$1" in
        -v|--verbose)
            verbose=true
            shift
            ;;
        -h|--help)
            usage
            exit 1
            ;;
        --)
            shift
            break;
            ;;
        *)
            echo "Invalid option \"$1\""
            usage
            exit 2
            ;;
    esac
done

DOTFILES="$HOME/Dotfiles"

alacritty=false
fish=false
i3=false
sway=false
shell=false
system=false
vim=false

mail=false
calendar=false
shell=false
scripts=false
wm=false
xWin=false
system=false
systemd=false
git=false
app=false
homeServer=false

# Symlinks file $1 to destination $2
#
# Destination $2 gets deleted in this process.
function linker() {
    local source=$(realpath -s "$1")
    local destination=$(realpath -s "$2")

    log_info "Link '$source' to '$destination'"
    if [[ -f "$destination" && ! -L "$destination" ]]; then
        log_info "Destination '$destination' needs to be replaced by symlink. Deleting it?"
        if ! do_confirm; then
            log_err "Failed to install '$source' to '$destination'"
            return 2
        fi
    fi
    rm -rf "$destination" >/dev/null 2>&1
    if [ -f "$destination" ]; then
        log_err "Failed to delete destination. Try with sudo?"
        if ! do_confirm; then
            log_err "Failed to install '$source' to '$destination'"
            return 2
        fi
        sudo rm -rf "$destination" >/dev/null 2>&1
        if [ -f "$destination" ]; then
            log_err "Unable to delete file. Exit"
            exit 2
        fi
    fi

    parentdir="$(dirname "$destination")"
    mkdir -p "$parentdir"
    ln -sf "$source" "$destination"
}

# Symlinks all files in $1 to destination folder $2
function dir_content_linker() {
    local source_dir="$1"
    local destination_dir="$2"

    if [[ ! -d "$source_dir" || ! -d "$destination_dir" ]]; then
        log_err "Both source and destination are supposed to be a directory. Exit."
        exit 2
    fi

    for file in "$source_dir/*"; do
        linker "$file" "$destination_dir"
    done
}

# TODO: Port coloniser
# Replaces color placeholders in $1 and copies it to $2
## Caution: destination $2 gets removed!
function colorizer() {

    local dir="$(dirname $2)"

    echo "Color Link {$1} to {$2}"
    sudo rm -rf "$dir" > /dev/null 2>&1
    mkdir -p "$dir"
    sh $DOTFILES/colorizer.sh "$1" "$2"
}

case "$(cat /etc/hostname)" in
    jcarch)
        log_info "Private system detected"
        fish=true
        alacritty=true
        i3=true
        system=true
        vim=true

        mail=true
        calendar=true
        shell=true
        scripts=true
        wm=true
        xWin=true
        system=true
        systemd=true
        git=true
        app=true
        ;;
    jceth)
        log_info "Work system detected"
        fish=true
        alacritty=true
        sway=true
        system=true
        vim=true
        ;;
    hs)
        log_info "Server system detected"
        shell=true
        vim=true
        git=true
        homeServer=true
        ;;
    cn*)
        log_info "Node system detected"
        ;;
    *)
        log_err "Unknown system detected. Exit."
        exit 2
        ;;
esac

if [ "$fish" = true ]; then
    linker "$DOTFILES/fish" "$XDG_CONFIG_HOME/fish"
fi

if [ "$alacritty" = true ]; then
    linker "$DOTFILES/alacritty/alacritty.toml" "$XDG_CONFIG_HOME/alacritty/alacritty.toml"
fi

if [ "$i3" = true ]; then
    linker "$DOTFILES/wm/i3" "$XDG_CONFIG_HOME/i3"
    linker "$DOTFILES/wm/i3blocks" "$XDG_CONFIG_HOME/i3blocks"
    linker "$DOTFILES/wm/i3scripts" "$XDG_CONFIG_HOME/i3scripts"
fi

if [ "$sway" = true ]; then
    linker "$DOTFILES/sway" "$XDG_CONFIG_HOME/sway"
    linker "$DOTFILES/waybar/config.jsonc" "$XDG_CONFIG_HOME/waybar/config.jsonc"
fi

if [ "$system" = true ]; then
    # Various System Configurations
    linker "$DOTFILES/fontconfig" "$XDG_CONFIG_HOME/fontconfig"
    linker "$DOTFILES/mimeapps.list" "$XDG_CONFIG_HOME/mimeapps.list"
    linker "$DOTFILES/locale.conf" "$XDG_CONFIG_HOME/locale.conf"
    linker "$DOTFILES/Ssh/config" "$HOME/.ssh/config"
fi

if [ "$vim" = true ]; then
    linker "$DOTFILES/Nvim/init.lua" "$XDG_CONFIG_HOME/nvim/init.lua"
    linker "$DOTFILES/Nvim/lua" "$XDG_CONFIG_HOME/nvim/lua"
fi


exit 1

if [ "$zsh" = true ]; then
    mkdir -p ~/.config/zsh
    linker "$DOTFILES/zsh/.zshrc" ~/.config/zsh/.zshrc
    linker "$DOTFILES/zsh/.zlogin" ~/.config/zsh/.zlogin
    linker "$DOTFILES/zsh/.zprofile" ~/.config/zsh/.zprofile
    linker "$DOTFILES/zsh/alias.zsh" ~/.config/zsh/alias.zsh
    linker "$DOTFILES/zsh/prompt.zsh" ~/.config/zsh/prompt.zsh
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/zsh/zshenv\" '/etc/zsh/zshenv'" # Run as root
fi

### X
if [[ "$xWin" = true ]]
then
    linker "$DOTFILES/X11/Xresources" ~/.config/X11/Xresources
    linker "$DOTFILES/X11/xcolors" ~/.config/X11/xcolors
    linker "$DOTFILES/X11/xinitrc" ~/.config/X11/xinitrc
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/X11/00-keyboard.conf\" /etc/X11/xorg.conf.d/00-keyboard.conf"
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/X11/40-mouse-sensitivity.conf\" /etc/X11/xorg.conf.d/40-mouse-sensitivity.conf"
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/X11/20-intel.conf\" /etc/X11/xorg.conf.d/20-intel.conf"
    xrdb ~/.config/X11/Xresources

    linker "$DOTFILES/gtk-3.0" ~/.config/gtk-3.0
    linker "$DOTFILES/gtk-2.0" ~/.config/gtk-2.0

    linker "$DOTFILES/icc/Displaycal/DisplayCAL.ini" ~/.config/DisplayCAL/DisplayCAL.ini
    linker "$DOTFILES/Tmux/tmux.conf" ~/.config/tmux/tmux.conf
fi


if [[ "$systemd" = true ]]
then
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/acpi\" '/etc/acpi'" # Run as root
    linker "$DOTFILES/systemd" ~/.config/systemd
    linker "$DOTFILES/rsync_tmbackup/exclude_list" ~/.local/share/rsync_tmbackup/exclude_list
fi

if [[ "$homeServer" = true ]]
then
    mkdir -p ~/HomeServer
    dir_content_linker "$DOTFILES/HomeServer/" ~/HomeServer
fi

## Scripts
if [[ "$scripts" = true ]]
then
    linker "$DOTFILES/Scripts/displayer" ~/bin/displayer
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/Scripts/displayer\" '/bin/displayer'"
    linker "$DOTFILES/Scripts/lock.sh" ~/bin/lock.sh
    linker "$DOTFILES/Scripts/battery.sh" ~/bin/battery.sh
    linker "$DOTFILES/Scripts/bluetooth.sh" ~/bin/bluetooth.sh
    linker "$DOTFILES/Scripts/mailChecker.sh" ~/bin/mailChecker.sh
    linker "$DOTFILES/Scripts/monitor.sh" ~/bin/monitor.sh
    linker "$DOTFILES/Scripts/screenRotation.sh" ~/bin/screenRotation.sh
    linker "$DOTFILES/Scripts/backlight.sh" ~/bin/backlight.sh
    linker "$DOTFILES/Scripts/note" ~/bin/note
    linker "$DOTFILES/Scripts/mail" ~/bin/mail
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/Scripts/backlight.sh\" '/bin/backlight.sh'"
    linker "$DOTFILES/Scripts/volume.sh" ~/bin/volume.sh
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/Scripts/volume.sh\" '/bin/volume.sh'"
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/Scripts/scrotMenu.sh\" '/bin/scrotMenu.sh'"
    sudo bash -c "$(declare -f linker); linker \"$DOTFILES/Scripts/monitorMenu.sh\" '/bin/monitorMenu.sh'"
    linker "$DOTFILES/Scripts/wwan.sh" ~/bin/wwan.sh
    linker "$DOTFILES/Scripts/cryptMount.sh" ~/bin/cryptMount
    linker "$DOTFILES/Scripts/cryptUmount.sh" ~/bin/cryptUmount
    linker "$DOTFILES/Scripts/sourcevenv" ~/bin/sourcevenv
    linker "$DOTFILES/Scripts/o" ~/bin/o
fi

## Applications

### Git
if [[ "$git" = true ]]
then
    linker "$DOTFILES/Git/config" ~/.config/git/config
    linker "$DOTFILES/Git/gitignore_global" ~/.config/git/gitignore_global
fi

### Other Applications
if [[ "$app" = true ]]
then
    linker "$DOTFILES/redshift" ~/.config/redshift
    colorizer "$DOTFILES/dunst/dunstrc.raw" ~/.config/dunst/dunstrc
    linker "$DOTFILES/mpv" ~/.config/mpv
    linker "$DOTFILES/yt-dlp" ~/.config/yt-dlp
    linker "$DOTFILES/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
    linker "$DOTFILES/qutebrowser/config.py" ~/.config/qutebrowser/config.py
    linker "$DOTFILES/Vimiv/vimiv.conf" ~/.config/vimiv/vimiv.conf
    linker "$DOTFILES/Vimiv/keys.conf" ~/.config/vimiv/keys.conf
    linker "$DOTFILES/Newsboat" ~/.config/newsboat
    linker "$DOTFILES/Rofi" ~/.config/rofi
    linker "$DOTFILES/Wget" ~/.config/wget
    linker "$DOTFILES/Gnupg/gpg-agent.conf" ~/.gnupg/gpg-agent.conf
    linker "$DOTFILES/Gnupg/gpg.conf" ~/.gnupg/gpg.conf
    linker "$DOTFILES/Taskwarrior/taskrc" ~/.config/taskwarrior/taskrc
    linker "$DOTFILES/Taskwarrior/dark-16.theme" ~/.config/taskwarrior/dark-16.theme
    linker "$DOTFILES/Taskwarrior/on-modify.timewarrior" ~/.local/share/taskwarrior/hooks/on-modify.timewarrior
    linker "$DOTFILES/Timewarrior/timewarrior.cfg" ~/.config/timewarrior/timewarrior.cfg
    linker "$DOTFILES/Timewarrior/dark.theme" ~/.config/timewarrior/dark.theme
    linker "$DOTFILES/Cabal/config" ~/.cabal/config
    linker "$DOTFILES/StudyManager" ~/.config/studyManager
    linker "$DOTFILES/gdb" ~/.config/gdb
    linker "$DOTFILES/language/vale" ~/.config/vale
    linker "$DOTFILES/language/dict" ~/.local/share/dict
    linker "$DOTFILES/Zathura/zathurarc" ~/.config/zathura/zathurarc
    linker "$DOTFILES/Poetry/config.toml" ~/.config/pypoetry/config.toml
fi

## Mail
if [[ "$mail" = true ]]
then
    linker "$DOTFILES/Mail/mutt" ~/.config/mutt
    linker "$DOTFILES/Mail/msmtp" ~/.config/msmtp
    mkdir -p "$HOME/.config/isync"
    linker "$DOTFILES/Mail/.mbsyncrc" ~/.config/isync/mbsyncrc
    linker "$DOTFILES/Mail/muttprint" ~/.config/muttprint
    linker "$DOTFILES/Mail/notmuch" ~/.config/notmuch/config
fi

## Calendar
if [[ "$calendar" = true ]]
then
    linker "$DOTFILES/CalCard/Khal" ~/.config/khal
    linker "$DOTFILES/CalCard/VdirSyncer" ~/.config/vdirsyncer
    linker "$DOTFILES/Todoman" ~/.config/todoman
    linker "$DOTFILES/CalCard/Khard" ~/.config/khard
fi

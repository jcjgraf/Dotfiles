# XDG Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export XDG_DESKTOP_DIR="$HOME/"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/"
export XDG_PUBLICSHARE_DIR="$HOME/"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Images"
export XDG_VIDEOS_DIR="$HOME/"

# Default Applications
export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="termite"
export BROWSER="qutebrowser"
export READER="zathura"

# Add ~/bin and ~/.local/bin to path
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# Custom Export
export DOTFILES=~/Dotfiles
export eth=~/Documents/Studies/Eth/Semester4/
export amb=${eth}AutonomousMobileRobots/
export cn=${eth}ComputerNetworks/
export dmdb=${eth}DataModellingAndDatabases/
export fmfp=${eth}FormalMethodsAndFunctionalProgramming/
export ws=${eth}WahrscheinlichkeitUndStatistik/

export TERM=xterm-color

# Required that GPG works on SSH
export GPG_TTY=$(tty)
stty sane

# Fix for something, but not sure what
export DISPLAY=:0.0;
export GPG_TTY=/dev/pts/2

# NPM
NPM_PACKAGES=
export PATH="$PATH:${HOME}/.npm-packages/bin"

# Ledger
export LEDGER_FILE=~/Documents/Finanzen/Ausgaben/2021.journal

# LESS
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# Pass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass

# Pylint
export PYLINTHOME="$XDG_CACHE_HOME"/pylint

# Virtualenv
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"

# wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# xorg-xauth
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

# xinit
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

# GTK 2
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# Timewarrior
export TIMEWARRIORDB="$XDG_CONFIG_HOME"/timewarrior

# Taskwarrior
export TASKRC="$XDG_CONFIG_HOME"/taskwarrior/taskrc
export TASKDATA="$XDG_DATA_HOME"/taskwarrior

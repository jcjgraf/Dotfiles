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

# Add cabal path
export PATH="$PATH:$HOME/.cabal/bin"

# Add go path
export PATH="$PATH:$HOME/go/bin"

# Custom Export
export DOTFILES=~/Dotfiles
export eth=~/Documents/Studies/Eth/Semester8

export TERM=xterm-color

# Required that GPG works on SSH
export GPG_TTY=$(tty)
stty sane

# SSH agent
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Fix for something, but not sure what
export DISPLAY=:0.0;
export GPG_TTY=/dev/pts/2

# LS Colors
export LS_COLORS="no=97:fi=97:di=34:ln=36:or=1;31:ex=35"

#no=(NORMAL, NORM) Global default, although everything should be something
#fi=(FILE) Normal file
#di=(DIR) Directory
#ln=(SYMLINK, LINK, LNK) Symbolic link. If you set this to 'target' instead of a numerical value, the colour is as for the file pointed to.
#pi=(FIFO, PIPE) Named pipe
#do=(DOOR) Door
#bd=(BLOCK, BLK) Block device
#cd=(CHAR, CHR) Character device
#or=(ORPHAN) Symbolic link pointing to a non-existent file
#so=(SOCK) Socket
#su=(SETUID) File that is setuid (u+s)
#sg=(SETGID) File that is setgid (g+s)
#tw=(STICKY_OTHER_WRITABLE) Directory that is sticky and other-writable (+t,o+w)
#ow=(OTHER_WRITABLE) Directory that is other-writable (o+w) and not sticky
#st=(STICKY) Directory with the sticky bit set (+t) and not other-writable
#ex=(EXEC) Executable file (i.e. has 'x' set in permissions)
#mi=(MISSING) Non-existent file pointed to by a symbolic link (visible when you type ls -l)
#lc=(LEFTCODE, LEFT) Opening terminal code
#rc=(RIGHTCODE, RIGHT) Closing terminal code
#ec=(ENDCODE, END) Non-filename text
#*.extension Every file using this extension e.g. *.jpg


# NPM
NPM_PACKAGES=
export PATH="$PATH:${HOME}/.npm-packages/bin"

# Ledger
export LEDGER_FILE=~/Documents/Finanzen/Ausgaben/2023.journal

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

# GHC
export GHCUP_USE_XDG_DIRS=1

# VIT
export VIT_DIR="$XDG_CONFIG_HOME"/vit

# opam configuration
[[ ! -r /home/jeanclaude/.opam/opam-init/init.zsh ]] || source /home/jeanclaude/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# JDTLS LSP Server for Java
export JDTLS_HOME=/usr/share/java/jdtls

# Notmuch
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/config

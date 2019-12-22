#export PATH=$HOME/bin:/usr/local/bin:$PATH

ZSH_THEME=""
CASE_SENSITIVE="true"
plugins=(git history-substring-search)

# Source oh-my-zsh, alias and custom theme
source $HOME/.oh-my-zsh/oh-my-zsh.sh
source ./alias.zsh
source ./jc.zsh-theme

# History
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000

setopt appendhistory autocd extendedglob nomatch notify

bindkey -v

zstyle :compinstall filename '~/.zshrc'

# Autocompletion
autoload -Uz compinit
compinit

# Custom Export
export eth=~/Documents/Studies/Eth/Semester1/
export VISUAL=vim
export EDITOR=vim

export TERM=xterm-color

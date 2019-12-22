export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=~/.oh-my-zsh
export DOTFILES=~/Dotfiles

ZSH_THEME=""
CASE_SENSITIVE="true"
plugins=(git history-substring-search)

# Source oh-my-zsh, alias and custom theme
source $ZSH/oh-my-zsh.sh
source $DOTFILES/zsh/alias.zsh
source $DOTFILES/zsh/jc.zsh-theme

# History
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000

setopt appendhistory autocd extendedglob nomatch notify

bindkey -v

zstyle :compinstall filename '~/.zshrc'

# Autocompletion
autoload -Uz compinit
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

# Custom Export
export eth=~/Documents/Studies/Eth/Semester1/
export VISUAL=vim
export EDITOR=vim

export TERM=xterm-color

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=~/.oh-my-zsh
export DOTFILES=~/Dotfiles

# Required that GPG works on SSH
export GPG_TTY=$(tty)
stty sane

ZSH_THEME=""
CASE_SENSITIVE="true"
plugins=(git history-substring-search docker docker-compose)

# Source oh-my-zsh, alias and custom theme
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/alias.zsh
source $ZSH/custom/themes/jc.zsh-theme

# History
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

setopt appendhistory autocd extendedglob nomatch notify

bindkey -v

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

# Custom Export
export eth=~/Documents/Studies/Eth/Semester2/
export pp=${eth}ParalelleProgrammierung/
export ana=${eth}AnalysisI/
export aw=${eth}AlgorithmenUndWahrscheinlichkeiten/
export dd=${eth}DigitalDesignAndComputerArchitectures/
export gt=${eth}GameTheory/

export VISUAL=vim
export EDITOR=vim

export TERM=xterm-color

# NPM
NPM_PACKAGES=
export PATH="$PATH:${HOME}/.npm-packages/bin"

#
export PATH="$PATH:${HOME}/.local/bin"

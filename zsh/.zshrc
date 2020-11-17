export PATH=$HOME/bin:/usr/local/bin:/usr/bin/:$PATH
export ZSH=~/.oh-my-zsh
export DOTFILES=~/Dotfiles
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

ZSH_THEME=""
CASE_SENSITIVE="true"
plugins=(git history-substring-search docker docker-compose)

# Source oh-my-zsh, alias and custom theme
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/alias.zsh
source $ZSH/custom/themes/jc.zsh-theme

# History
HIST_STAMPS="mm/dd/yyyy"  # Timestamp in history
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

setopt appendhistory autocd extendedglob nomatch notify

bindkey -v

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

# Custom Export
export eth=~/Documents/Studies/Eth/Semester3/
export ana=${eth}AnalysisII/
export num=${eth}NumericalMethods/
export sp=${eth}SystemProgrammingAndComputerArchitectures/
export ti=${eth}TheoretischeInformatik/
export cs=${eth}Cybersicherheitspolitik/
export cd=${eth}CompilerDesign/

export VISUAL=nvim
export EDITOR=nvim

export TERM=xterm-color

# Required that GPG works on SSH
export GPG_TTY=$(tty)
stty sane

# NPM
NPM_PACKAGES=
export PATH="$PATH:${HOME}/.npm-packages/bin"

#
export PATH="$PATH:${HOME}/.local/bin"

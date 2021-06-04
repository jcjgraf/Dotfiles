# Enable colors for various commands
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color'

# Parent dir naviagation
alias -g ..='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'

alias l='ls -lah'
alias c='clear'
alias o='xdg-open'
alias g='git'
alias copy='xclip'
alias copyc='xclip -selection clipboard'
alias paste='xclip -o'
alias sd='sudo shutdown -h now'
alias hb='systemctl hibernate'
alias sc='scrot'
alias yt='mpsyt'
alias -g vim='nvim'
alias -g vi='nvim'
alias -g vimiv='~/Documents/Programming/vimiv-qt/.venv/bin/vimiv'
alias _='sudo'

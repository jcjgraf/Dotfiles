# Enable colors for various commands
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color'

# Parent dir naviagation
alias ..='cd ..'
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g ......='cd ../../../../..'

alias md='mkdir -p'

alias l='ls -lah'
alias tree='tree -a'
alias c='clear'
alias g='git'
alias copy='xclip'
alias copyc='xclip -selection clipboard'
alias paste='xclip -o'
alias sd='sudo shutdown -h now'
alias hb='systemctl hibernate'
alias sc='scrot'
alias yt='pipe-viewer'
alias -g vim='nvim'
alias -g vi='nvim'
alias _='sudo'

alias ethnet='echo `pass show online/ethz.ch/radius/jegraf`"\n"`pass otp show online/ethz.ch/jegraf_MFE` | sudo openconnect --user jegraf@student-net.ethz.ch --passwd-on-stdin --useragent "AnyConnect" sslvpn.ethz.ch/student-net'
alias homenet='cd ~/Documents/Certificates && sudo openvpn er.ovpn'
alias nosleep='xset s off && xset -dpms'

alias bing='paplay /usr/share/sounds/freedesktop/stereo/complete.oga'

alias webcam='mpv --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg av://v4l2:/dev/video0'

alias clang_f='clang-format --style="{BasedOnStyle: LLVM, IndentWidth: 4, ColumnLimit: 90}" -i **/*.c **/*.h'
alias clang_f_dump='clang-format --dump-config --style="{BasedOnStyle: LLVM, IndentWidth: 4}" > .clang-format'
alias raw2jpg='exiftool -b -jpgfromraw -w %d%f_%ue.jpg -execute -tagsfromfile @ -srcfile %d%f_%ue.jpg -overwrite_original -common_args'

alias cdf='cd $(find . -type d -print | fzf)'

alias objdump="objdump --disassembler-color=on --visualize-jumps=color"

alias git-diff="git diff --no-index --word-diff=color --word-diff-regex=."

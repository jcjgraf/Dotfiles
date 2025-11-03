function copyc --wraps='xclip -selection clipboard' --description 'alias copyc=xclip -selection clipboard'
    xclip -selection clipboard $argv
end

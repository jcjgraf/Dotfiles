function __vim_fallback
    if type -q nvim
        command nvim $argv
    else if type -q vim
        command vim $argv
    else if type -q vi
        command vi $argv
    else
        echo "Error: no editor (nvim/vim/vi) found." >&2
        return 1
    end
end

function vim --description 'Use nvim if available, else vim, else vi'
    __vim_fallback $argv
end

function vi --description 'Use nvim if available, else vim, else vi'
    __vim_fallback $argv
end

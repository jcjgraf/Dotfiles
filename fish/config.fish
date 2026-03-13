if status is-interactive
    # Start Vim mode
    fish_vi_key_bindings

    # From https://superuser.com/a/944589/673743
    function bind_bang
        switch (commandline -t)[-1]
            case "!"
                commandline -t -- $history[1]
                commandline -f repaint
            case "*"
                commandline -i !
        end
    end

    function bind_dollar
        switch (commandline -t)[-1]
            case "!"
                commandline -f backward-delete-char history-token-search-backward
            case "*"
                commandline -i '$'
        end
    end

    function fish_user_key_bindings
        bind ! bind_bang
        bind '$' bind_dollar
        # CTRL+C does not clear command line, but cancels input and goes to a new line
        bind -M insert \cc 'echo; commandline | cat; commandline ""; commandline -f repaint'
    end

    zoxide init fish | source
end

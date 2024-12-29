if [ "$XDG_VTNR" -eq 1 ]; then
    # Only run startx if not running as TMUX
    if [ -z "$TMUX" ]; then
        startx "$HOME/.config/X11/xinitrc"
    fi
fi

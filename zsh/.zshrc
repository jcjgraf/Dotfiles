source $ZDOTDIR/alias.zsh
source $ZDOTDIR/prompt.zsh

# History

setopt EXTENDED_HISTORY        # Record command start time
setopt INC_APPEND_HISTORY_TIME # Update history after each command instead on shell exit. Also record the duration
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicates first
setopt HIST_IGNORE_DUPS        # Do not store duplications
setopt HIST_SAVE_NO_DUPS       # No not store duplicates
setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicate
setopt HIST_REDUCE_BLANKS      # Remove space chars

HISTFILE="${XDG_CACHE_HOME}/zsh/history"
HISTSIZE=500000
SAVEHIST=500000

# Tab Completion
# Completions are stored in /usr/share/zsh/functions/Completion/*

setopt ALWAYS_TO_END    # When completing, move cursor to end of line
setopt COMPLETE_IN_WORD # Cursor stays when completing inside word
setopt HIST_VERIFY      # Show substituted history command instead of running

autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump"

zmodload zsh/complist # Needed for list-colors completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colored completion
zstyle ':completion:*' menu select                      # Cycle through completions

zstyle ':completion:*' special-dirs true # Complete speciel dirs like . and ..

# Use chache to speed up completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Partial matching

bindkey -M menuselect '\C-x\i' vi-insert # Switch to interactive insert

_comp_options+=(globdots) # Tab complete hidden files

# Bindings

# Make arrow keys search history 
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

bindkey '^?' backward-delete-char # Backward delete using backspace
bindkey  "^[[3~"  delete-char     # Forward Delete using delete key

# Edit current command in EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-e' edit-command-line

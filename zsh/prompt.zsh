setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git                                                           # Enable for git
zstyle ':vcs_info:*' stagedstr 'M'                                                        # Char replaced by %c. If there are staged changes
zstyle ':vcs_info:*' unstagedstr 'M'                                                      # Char replaced by %u. If there are unstaged changed
zstyle ':vcs_info:*' check-for-changes true                                               # Enable check for staged and unstaged files
zstyle ':vcs_info:*' actionformats '%F{green}[%F{green}%b%F{blue}|%F{red}%a%F{green}]%f ' # Formatting during action (like rebase)
zstyle ':vcs_info:*' formats '%F{green}[%F{blue}%b%F{green}] %F{green}%c%F{yellow}%u%f'   # General formatting

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Deal with untracked files
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]]
        then
        hook_com[unstaged]+='%F{red}??%f'
    fi
}

precmd () { vcs_info }

PROMPT='
%B%F{blue}#%f%b \
%B%F{yellow}%~%f\
 ${vcs_info_msg_0_}\
%(?..%F{red} > %?)%f
%B%F{red} %f%b'

RPROMPT="%F{green}%*%f"

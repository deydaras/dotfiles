# ~/.bashrc
# Clean Bash config, adapted for Arch + Zellij + vi mode + git branch

# Only run in interactive shells
[[ $- != *i* ]] && return
# Vi-style editing in bash
set -o vi
# paste system clipboard with p

# Let readline show the current mode in the prompt
bind 'set show-mode-in-prompt on'

# Insert mode: green [I] + thin bar cursor
bind 'set vi-ins-mode-string \1\e[32m\e[6 q\2[I]\1\e[0m\2 '

# Normal/command mode: red [N] + block cursor
bind 'set vi-cmd-mode-string \1\e[31m\e[2 q\2[N]\1\e[0m\2 '
# -----------------------------
# History
# -----------------------------
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:cd -:pwd:exit:clear"
shopt -s histappend
PROMPT_COMMAND='history -a; history -n'

# -----------------------------
# Shell behavior
# -----------------------------
shopt -s checkwinsize
shopt -s cmdhist
shopt -s no_empty_cmd_completion
set -o noclobber

# -----------------------------
# Defaults
# -----------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R"

# -----------------------------
# PATH
# -----------------------------
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
export PATH

# -----------------------------
# Safer aliases
# -----------------------------
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# -----------------------------
# Useful aliases
# -----------------------------
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'
alias q='exit'
alias vim='nvim'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias mkdir='mkdir -pv'
alias reload='source ~/.bashrc'
alias config='cd ~/.config'
alias pyvenv='python3 -m venv .venv'
alias venvact='. .venv/bin/activate'
# alias -='cd -'

# -----------------------------
# Arch aliases
# -----------------------------
alias paci='sudo pacman -S'
alias pacr='sudo pacman -Rns'
alias pacu='sudo pacman -Syu'
alias pacs='pacman -Ss'
alias paciinfo='pacman -Qi'
alias pacfiles='pacman -Ql'

# Uncomment if you use yay
alias yai='yay -S'
alias yau='yay -Syu'
alias yas='yay -Ss'
alias yar='yay -Rns'

  
# Zellij
alias li='zellij'
alias lim='zellij attach -c main'
alias lid='zellij attach -c dev'
alias lis='zellij list-sessions'
alias lik='zellij kill-session main 2>/dev/null'

# -----------------------------
# Completion / readline
# -----------------------------
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "TAB:menu-complete"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-h": backward-kill-word'

# -----------------------------
# Bash completion
# -----------------------------
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

# -----------------------------
# Helpers
# -----------------------------
mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz)  tar xzf "$1" ;;
        *.bz2)     bunzip2 "$1" ;;
        *.rar)     unrar x "$1" ;;
        *.gz)      gunzip "$1" ;;
        *.tar)     tar xf "$1" ;;
        *.tbz2)    tar xjf "$1" ;;
        *.tgz)     tar xzf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.7z)      7z x "$1" ;;
        *) echo "unknown format: $1" ;;
    esac
}

# -----------------------------
# Git branch in prompt
# -----------------------------
__bash_git_branch() {
    git branch --show-current 2>/dev/null
}

# -----------------------------
# Vi mode indicator
# ELI5:
# Bash has two editing modes:
#   insert mode = you type text
#   command mode = like vim normal mode
#
# This function shows [I] or [N] in the prompt.
# Bash updates this variable automatically when vi mode is enabled.
# -----------------------------
__bash_vi_mode() {
    if [[ ${READLINE_LINE-} || ${READLINE_POINT-0} -ge 0 ]]; then
        case "${READLINE_STATE-}" in
            *cmd*) echo "[N]" ;;
            *)     echo "[I]" ;;
        esac
    else
        echo "[I]"
    fi
}

# -----------------------------
# Prompt
# Adapted for Zellij:
# - compact enough for panes
# - still shows git branch
# - still shows vi mode
# - no fragile multiline tricks
# -----------------------------
if [[ -n "$ZELLIJ" ]]; then
    PS1='\[\e[1;32m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \[\e[0;33m\]$(__bash_git_branch)\[\e[0m\] \[\e[1;35m\]$(__bash_vi_mode)\[\e[0m\] \$ '
else
    PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\] \[\e[0;33m\]$(__bash_git_branch)\[\e[0m\] \[\e[1;35m\]$(__bash_vi_mode)\[\e[0m\]\n❯ '
fi

# -----------------------------
# Optional: auto-start Zellij for local interactive shells
# Uncomment if you want Bash to launch directly into Zellij
# -----------------------------
# if command -v zellij >/dev/null 2>&1; then
#     if [[ -z "$ZELLIJ" && -z "$SSH_CONNECTION" && "$TERM" != "dumb" ]]; then
#         exec zellij
#     fi
# fi
# vi mode

__paste_clipboard_after() {
    local clip
    clip="$(wl-paste 2>/dev/null || true)"

    if [ -z "$clip" ]; then
        clip="$(wl-paste --primary 2>/dev/null || true)"
    fi

    [ -z "$clip" ] && return

    READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}${clip}${READLINE_LINE:READLINE_POINT}"
    READLINE_POINT=$((READLINE_POINT + ${#clip}))
}

__paste_clipboard_before() {
    local clip
    clip="$(wl-paste 2>/dev/null || true)"

    if [ -z "$clip" ]; then
        clip="$(wl-paste --primary 2>/dev/null || true)"
    fi

    [ -z "$clip" ] && return

    READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}${clip}${READLINE_LINE:READLINE_POINT}"
}

bind -m vi-command -x '"p": __paste_clipboard_after'
bind -m vi-command -x '"P": __paste_clipboard_before'
# -----------------------------
# Optional local extensions
# -----------------------------
[[ -f "$HOME/.bash_aliases" ]] && . "$HOME/.bash_aliases"
[[ -f "$HOME/.bash_local" ]] && . "$HOME/.bash_local"

# ~/.bashrc

# 1. STOP background processes from running the rest of this script
[[ $- != *i* ]] && return

# 2. Basic Settings & Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias bashrcv='nvim ~/.bashrc'
alias bashrcs='source ~/.bashrc'
alias pacs='sudo pacman -S '
alias pacu='sudo pacman -Syu' 
alias nv='nvim .'
alias pyvenv='python3 -m venv .venv'
alias venvact='. .venv/bin/activate'
alias li='zellij attach -c $(basename "$PWD")'
# Auto-start zellij on WSL
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

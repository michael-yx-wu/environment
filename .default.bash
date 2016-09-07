#!/usr/bin/env bash

# Determine OS
platform='unknown'
if [ "$(uname)" == 'Darwin' ]; then
    platform="OSX"
elif [ "$(uname)" == 'Linux' ]; then
    platform="Linux"
fi

# Bash prompt
if [ "$platform" == 'OSX' ]; then
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        # shellcheck source=/dev/null
        source $(brew --prefix)/etc/bash_completion
        # shellcheck source=/dev/null
        source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
        export GIT_PS1_SHOWDIRTYSTATE=1
        export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \[\033[01;33m\]$(__git_ps1) \[\033[01;34m\]> \[\033[00m\]'
    else
        echo 'Warn: bash_completion not found'
        export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \[\033[01;34m\]> \[\033[00m\]'
    fi
elif [ "$platform" == 'Linux' ]; then
    if [ -f /etc/bash_completion ]; then
        # shellcheck disable=SC1091
        source /etc/bash_completion
       export GIT_PS1_SHOWDIRTYSTATE=1
        export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \[\033[01;33m\]$(__git_ps1) \[\033[01;34m\]> \[\033[00m\]'
    else
        echo 'Warn: bash_completion not found'
        export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \[\033[01;34m\]> \[\033[00m\]'
    fi
else
    echo 'Unknown platform: not customizing bash prompt'
fi

# Git autocomplete
if [ -f ~/.git-completion.bash ]; then
    # shellcheck source=/dev/null
    source ~/.git-completion.bash
fi

# Highlighting
export GREP_OPTIONS='--color=auto'
if [ "$platform" == 'OSX' ]; then
    export LSCOLORS="Exfxcxdxbxegedabagacad"
    alias ls="ls -G"
elif [ "$platform" == 'Linux' ]; then
    export LS_COLORS="Exfxcxdxbxegedabagacad"
    alias ls="ls --color=auto"
else
    echo 'Unknown platform: not setting alias for ls'
fi

# Navigation
alias ..='cd ..'

# Program aliases
alias vi='vim'

# Git aliases
alias gau='git add -u'
alias gc='git commit'
alias gca='git commit --amend'
alias gl='git log'
alias gp='git push'
alias gpf='git push --force'
alias gpn='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias grl='git reflog'
alias gs='git status'

# Set the title of the current tab
function title {
    echo -ne "\033]0;$*\007"
}

# Add current directory to PATH
export PATH=$PATH:.

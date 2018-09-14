#!/usr/bin/env bash

# Determine OS
platform='unknown'
if [ "$(uname)" == 'Darwin' ]; then
    platform="OSX"
elif [ "$(uname)" == 'Linux' ]; then
    platform="Linux"
fi

eval "$(rbenv init -)"
eval "$(nodenv init -)"
alias pyinit='eval "$(pyenv init -)"'

# Node / NPM
NODE_PATH="$(npm prefix -g)/lib/node_modules"
export NODE_PATH

# Java
eval "$(jenv init -)"

# Append current directory to path
export PATH=$PATH:.

# History
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE="$HISTSIZE"
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# PS1 and GIT_PS1 customization
if [ "$platform" == 'OSX' ]; then
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        # shellcheck source=/dev/null
        source $(brew --prefix)/etc/bash_completion
        # shellcheck source=/dev/null
        source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
        export GIT_PS1_SHOWDIRTYSTATE=1
        export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[01;33m\]$(__git_ps1) \[\033[01;34m\]> \[\033[00m\]'
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
alias ga='git add'
alias gaa='git add -A'
alias gau='git add -u'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit'
alias gca='git commit --amend'
alias gcd='git checkout develop'
alias gp='git push'
alias gpf='git push -f'
alias gpn='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gl='git log'
alias grl='git reflog'
alias gs='git status'
alias gt='git tree'
alias gtl='git tag --sort=v:refname'
alias sync-tags='git tag | xargs -n1 git tag -d && git fetch --tags'

# Docker aliases
alias dclean='/Users/michaelwu/code/dockerclean/dockerclean'
alias dnuke='docker kill $(docker ps -aq); docker rm -fv $(docker ps -aq)'

# Gradle aliases
alias gw='./gradlew'

# npm aliases
alias npmlg='npm list -g --depth=0'


# Utilities
function title {
    echo -ne "\033]0;$*\007"
}

# iTerm2 shell integration
# shellcheck source=/dev/null
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

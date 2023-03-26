# Determine OS
IS_MACOS=false
IS_APPLE_SILICON=false
IS_LINUX=false
if [ "$(uname)" == 'Darwin' ]; then
    IS_MACOS=true
    if [ "$(uname -m)" == 'arm64' ]; then
        IS_APPLE_SILICON=true
    fi
elif [ "$(uname)" == 'Linux' ]; then
    IS_LINUX=true
fi

# Add /usr/local/sbin to PATH for Homebrew
if $IS_APPLE_SILICON ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif IS_MACOS; then
    export PATH="/usr/local/sbin:$PATH"
fi

BREW_BASH="$(brew --prefix)/bin/bash"
if [ "$SHELL" == '/bin/bash' ] && [[ -f "$BREW_BASH" ]]; then
    echo "$BREW_BASH" | sudo tee -a '/etc/shells'
    chsh -s "$BREW_BASH"
fi

# Language version management init
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Not auto-initialized because homebrew historically installed things in weird locations if
# pyenv was initialized -- worth checking to see if this is still necessary
eval "$(pyenv init --path)"
if $IS_LINUX; then
    export PATH="$HOME/.nodenv/bin:$PATH"
fi
eval "$(nodenv init -)"
export SWIFTENV_ROOT="$HOME/.swiftenv"
export PATH="$SWIFTENV_ROOT/bin:$PATH"
eval "$(swiftenv init -)"

# Append current directory to path
export PATH=$PATH:.

# History
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE="$HISTSIZE"
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# Auto completion and prompt customization
export GIT_PS1_SHOWDIRTYSTATE=1
# shellcheck disable=SC2016
PROMPT_WITH_GIT='\[\033[01;32m\]\u \[\033[01;34m\]\w\[\033[01;33m\]$(__git_ps1) \[\033[01;34m\]> \[\033[00m\]'
PROMPT_WITHOUT_GIT='\[\033[01;32m\]\u \[\033[01;34m\]\w \[\033[01;34m\]> \[\033[00m\]'
WARN_NO_GIT_PROMPT='\e[1;33mbash_completion not found: prompt will not include __git_ps1\e[0m'
if $IS_MACOS || $IS_APPLE_SILICON; then
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        # shellcheck disable=SC1091
        source "$(brew --prefix)/etc/bash_completion"
        # shellcheck disable=SC1091
        source "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
        export PS1=$PROMPT_WITH_GIT
    else
        echo -e "$WARN_NO_GIT_PROMPT"
        export PS1=$PROMPT_WITHOUT_GIT
    fi
elif $IS_LINUX; then
    if [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
        for BASH_COMPLETION_FILE in /etc/bash_completion.d/* ; do
            # shellcheck disable=SC1090
            source "$BASH_COMPLETION_FILE"
        done
        export PS1=$PROMPT_WITH_GIT
    else
        echo -e "$WARN_NO_GIT_PROMPT"
        export PS1=$PROMPT_WITHOUT_GIT
    fi
else
    echo -e '\e[1;33mUnknown platform: not customizing prompt\e[0m'
fi

# Highlighting
export GREP_OPTIONS='--color=auto'
if $IS_MACOS; then
    export CLICOLOR=1
    export LSCOLORS='Exfxcxdxbxegedabagacad'
elif $IS_LINUX; then
    alias ls="ls --color=auto"
else
    echo -e '\e[1;33mUnknown platform: not setting ls colors\e[0m'
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
alias gfd='git fetch origin develop'
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

# npm aliases
alias npmlg='npm list -g --depth=0'

# Utilities
function title {
    echo -ne "\033]0;$*\007"
}

# Ignore default zsh shell prompt on Mac OS
export BASH_SILENCE_DEPRECATION_WARNING=1

# iTerm2 shell integration
# shellcheck source=/dev/null
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Make vscode available via command line
if [ -d '/Applications/Visual Studio Code.app/Contents/Resources/app/bin' ]; then
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

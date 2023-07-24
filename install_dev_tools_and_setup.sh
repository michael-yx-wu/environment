#!/usr/bin/env bash

set -e

IS_MACOS=false
if [ "$(uname)" == 'Darwin' ]; then
    IS_MACOS=true
fi

if $IS_MACOS; then
    # Install commandline tools
    if ! [ -x "$(command -v gcc)" ]; then
        sudo xcode-select --install
    fi

    # Install homebrew
    if ! [ -x "$(command -v brew)" ]; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    export HOMEBREW_NO_AUTO_UPDATE=1
    brew install git
    brew install git-lfs
    brew install bash
    brew install bash-completion
    brew install vim
    brew install nodenv
    brew install jenv
    brew install pyenv
    brew install shellcheck
    brew install diff-so-fancy
    brew tap gdubw/gng && brew install gng
    brew tap homebrew/cask-versions
    brew install corretto17
elif [ -x "$(command -v apt-get)" ]; then
    sudo add-apt-repository -y ppa:aos1/diff-so-fancy
    sudo apt-get update -y
    sudo apt-get install -y \
        git \
        git-lfs \
        bash \
        bash-completion \
        vim \
        shellcheck \
        diff-so-fancy

    # Install nodenv
    if ! [ -d "$HOME/.nodenv" ]; then
        git clone https://github.com/nodenv/nodenv.git ~/.nodenv
    else
        git -C ~/.nodenv pull
    fi

    # Install jenv
    if ! [ -d "$HOME/.jenv" ]; then
        git clone https://github.com/jenv/jenv.git ~/.jenv
    else
        git -C ~/.jenv pull
    fi

    # Install pyenv
    if ! [ -d "$HOME/.pyenv" ]; then
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    else
        git -C ~/.pyenv pull
    fi

    # Install gng
    curl -L https://github.com/gdubw/gng/releases/latest/download/gng-installer.sh | sudo bash
fi

# Install vim plugins
if ! [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

# Install shell integration
curl -L https://iterm2.com/shell_integration/bash -o ~/.iterm2_shell_integration.bash

# Keyboard
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
defaults write -g ApplePressAndHoldEnabled -bool false

# Move dotfiles into place
# TODO: replace with python to reduce tools needed
touch ~/.bash_profile
./environment.rb -s

# Silence last login message
touch ~/.hushlogin

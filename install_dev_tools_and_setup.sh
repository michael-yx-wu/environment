#!/usr/bin/env bash

set -e

# Install tools
if ! [ -x "$(command -v gcc)" ]; then
    sudo xcode-select --install
fi

# Install homebrew
if ! [ -x "$(command -v brew)" ]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Move dotfiles into place
# TODO: replace with python to reduce tools needed
touch ~/.bash_profile
./environment.rb -s

# Silence last login message
touch ~/.hushlogin

# Install tools
export HOMEBREW_NO_AUTO_UPDATE=1
brew install git
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

if ! [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

# Install shell integration
curl -L https://iterm2.com/shell_integration/bash  -o ~/.iterm2_shell_integration.bash

# Keyboard
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

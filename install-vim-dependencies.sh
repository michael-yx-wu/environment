#!/bin/bash

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Installing NERDCommenter
echo "Installing NERDCommenter"
(cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdcommenter.git)

# Install NERDTree
echo "Installing NERDTree"
(cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git)

# Installing SnipMate
echo "Installing SnipMate"
(cd ~/.vim/bundle && git clone https://github.com/msanders/snipmate.vim.git)

# Installing Solarized
echo "Installing Solarized"
(cd ~/.vim/bundle && git clone git://github.com/altercation/vim-colors-solarized.git)

# Install Yankring
echo "Installing Yankring"
(cd ~/.vim/bundle && git clone https://github.com/vim-scripts/YankRing.vim)


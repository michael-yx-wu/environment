#!/bin/bash

# Install bash script and dependencies
cp ./.standard.bash ~/.standard.bash
./install-bash-dependencies.sh
chmod +x ~/.standard.bash 

# Install vimrc and dependencies
cp ./.vimrc ~/.vimrc
./install-vim-dependencies.sh


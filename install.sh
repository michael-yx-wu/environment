#!/bin/bash

# Determine OS
uname=`uname -s`
platform="unknown"
if [ "$(uname)" == "Darwin" ]; then
    platform="OSX"
elif [ "$(uname)" == "Linux" ]; then
    platform="Linux"
fi

# Install bash script and dependencies
cp ./.standard.bash ~/.standard.bash
./install-bash-dependencies.sh
chmod +x ~/.standard.bash
if [ "$platform" == "OSX" ]; then
    echo '. ~/.standard.bash' >> ~/.bash_profile
elif [ "$platform" == "Linux" ]; then
    echo '. ~/.standard.bash' >> ~/.bashrc
fi

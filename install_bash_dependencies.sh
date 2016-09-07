#!/usr/bin/env bash

# Determine OS
platform='unknown'
if [ "$(uname)" == 'Darwin' ]; then
    platform='OSX'
elif [ "$(uname)" == 'Linux' ]; then
    platform='Linux'
fi

echo 'Installing bash-completion'
if [ "$platform" == 'OSX' ]; then
    brew install bash-completion
elif [ "$platform" == 'Linux' ]; then
    sudo yum install bash-completion -y
fi

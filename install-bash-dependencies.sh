#!/bin/bash

# Determine OS
uname=`uname -s`
platform="unknown"
if [ "$(uname)" == "Darwin" ]; then
    platform="OSX"
elif [ "$(uname)" == "Linux" ]; then
    platform="Linux"
fi

echo "Installing bash-completion"
if [ "$platform" == "OSX" ]; then
    brew install bash-completion
elif [ "$platform" == "Linux" ]; then
    sudo yum install bash-completion -y
fi

# Install git completion
echo "Installing git-completion.sh"
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o .git-completion.bash
mv .git-completion.bash ~/.git-completion.bash


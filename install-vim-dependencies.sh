#!/bin/bash

echo "Installing Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle
if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
    echo "Pathogen exists"
else 
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

packageInstallSuccess=0
echo "Installing NERDCommenter"
(cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdcommenter.git > /dev/null)
packageInstallSuccess=`expr $packageInstallSuccess + $?`

echo "Installing NERDTree"
(cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git > /dev/null)
packageInstallSuccess=`expr $packageInstallSuccess + $?`

echo "Installing SnipMate"
(cd ~/.vim/bundle && git clone https://github.com/msanders/snipmate.vim.git > /dev/null)
packageInstallSuccess=`expr $packageInstallSuccess + $?`

echo "Installing Solarized"
(cd ~/.vim/bundle && git clone git://github.com/altercation/vim-colors-solarized.git > /dev/null)
packageInstallSuccess=`expr $packageInstallSuccess + $?`

echo "Installing Yankring"
(cd ~/.vim/bundle && git clone https://github.com/vim-scripts/YankRing.vim > /dev/null)
packageInstallSuccess=`expr $packageInstallSuccess + $?`

if [ $packageInstallSuccess -ne 0 ]; then 
    echo "Warn: Some vim packages were not installed"
fi


#!/bin/bash

# refer  spf13-vim bootstrap.sh`
BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

if [[ ! -n "$PYTHON" ]];then
    PYTHON=`which python3`
    [[ $PYTHON == "" ]] && {
        echo "Please install the python3"
        exit 1
    }
fi

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}


echo "Step1: backing up current vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.vimrc.bundles; do
    if [[ -L $i ]];then
        unlink $i ;
    else
        [ -e $i ] && mv $i $i.$today;
    fi
done

echo "Step2: setting up symlinks"
lnif $CURRENT_DIR/vimrc $HOME/.vimrc
lnif $CURRENT_DIR/vimrc.bundles $HOME/.vimrc.bundles
lnif "$CURRENT_DIR/" "$HOME/.vim"

echo "Step3: update/install plugins using Vim-plug"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $HOME/.vimrc +PlugInstall! +PlugClean! +qall
export SHELL=$system_shell


echo "Step4: compile YouCompleteMe"
echo "It will take a long time, just be patient!"
echo "If error,you need to compile it yourself"
echo "cd $CURRENT_DIR/bundle/YouCompleteMe/ && python install.py --clang-completer"

cd $CURRENT_DIR/bundle/YouCompleteMe/
git submodule update --init --recursive
$PYTHON install.py --clang-completer

echo "Install Done!"
echo "Please check the Python interpreter for YouCompleteMe manually"
echo "let g:ycm_server_python_interpreter = '$PYTHON'"

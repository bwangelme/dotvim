#!/bin/bash

# refer  spf13-vim bootstrap.sh`
BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`


lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

install-nvim () {
    echo "Step1: backing up current vim config"
    today=`date +%Y%m%d`
    for i in $HOME/.config/nvim; do
        if [[ -L $i ]];then
            unlink $i ;
        else
            [ -e $i ] && mv $i $i.$today;
        fi
    done

    echo "Step2: setting up symlinks"
    lnif "$CURRENT_DIR/" "$HOME/.config/nvim"

    echo "Step3: update/install plugins using Vim-plug"
    system_shell=$SHELL
    export SHELL="/bin/sh"
    nvim -u $HOME/.config/nvim/init.vim +PlugInstall! +PlugClean! +qall
    export SHELL=$system_shell

    echo "Install Done!"
}

install-nvim || exit 1

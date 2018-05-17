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

install-vim () {
    echo "Step1: backing up current vim config"
    today=`date +%Y%m%d`
    files=( "$HOME/.vimrc" "$HOME/.vimrc.bundles" "$HOME/.vim" )
    for i in "${fiels[@]}"; do
        if [[ -L $i ]];then
            unlink $i ;
        else
            [ -e $i ] && mv $i $i.$today;
        fi
    done

    echo "Step2: setting up symlinks"
    lnif $CURRENT_DIR/vimrc $HOME/.vimrc
    lnif $CURRENT_DIR/vimrc.bundles $HOME/.vimrc.bundles
    lnif $CURRENT_DIR/ $HOME/.vim
}

install-vim || exit 1

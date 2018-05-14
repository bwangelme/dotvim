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

case "$1" in
    nvim)
        install-nvim || exit 1
        ;;
    vim)
        install-vim || exit 1
        ;;
    *)
        echo "Usage: $0 {vim|nvim}"
        ;;
esac

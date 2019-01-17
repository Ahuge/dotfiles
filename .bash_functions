#!/bin/bash

function wrapcfg() {
    __pd=`pwd`;
    cd $HOME;
    /usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME "$@";
    cd $__pd;
}

function prefs() {
    if [ -z $1 ]
    then
        $EDITOR $HOME/.bashrc
    else
        case $1 in
        functions)
            $EDITOR $HOME/.bash_$1
            ;;
        aliases)
            $EDITOR $HOME/.bash_$1
            ;;
        env)
            $EDITOR $HOME/.bash_$1
            ;;
        *)
            echo "Unknown file .bash_$1"
            ;;
        esac
    fi
}

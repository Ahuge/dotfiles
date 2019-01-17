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
        bash_files=$(echo $BASHFILES | tr ":" "\n")
        if [[ $bash_files =~ $1 ]]
        then
            $EDITOR $HOME/.bash$1
        else
            echo "ERROR: $1 is not a valid option!";
        fi
    fi
}

#!/bin/bash

function wrapcfg() {
  __pd=`pwd`;
  cd $HOME;
  /usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME "$@";
  cd $__pd;
}


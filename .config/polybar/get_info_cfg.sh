#!/bin/zsh

_changes=$(git --git-dir=$HOME/.cfg/ --work-tree=$HOME status --porcelain | wc -l)

if [[ $_changes -eq 0 ]]
then
    echo - "-"
else
    echo $_changes
fi

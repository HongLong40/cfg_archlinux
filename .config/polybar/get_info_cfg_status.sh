#!/bin/zsh

typeset -i _max_lines=30
typeset -i _lines=$(git --git-dir=$HOME/.cfg/ --work-tree=$HOME status --porcelain | wc -l)

if [[ ${_lines} -eq 0 ]]
then
    exit 0
fi

if [[ ${_lines} -gt ${_max_lines} ]]
then
    _lines=30
fi

git --git-dir=$HOME/.cfg/ --work-tree=$HOME status --porcelain | \
    rofi \
    -dmenu \
    -i \
    -xoffset -6 \
    -yoffset 30 \
    -p "Configuration Changes" \
    -no-show-icons \
    -theme-str "entry {enabled: false;} window {width: 25%; location: north east;} listview {lines: ${_lines}; spacing: 0px;}"

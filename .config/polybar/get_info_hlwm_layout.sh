#!/bin/zsh

_layout=$(herbstclient get_attr tags.focus.tiling.focused_frame.algorithm)
echo "%{B#1A5920}    λ${${_layout:0:1}:u}    %{B-}"
#echo ${${_layout:0:1}:u}


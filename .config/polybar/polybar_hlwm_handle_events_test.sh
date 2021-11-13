#!/bin/zsh

#_layout=$(herbstclient get_attr tags.focus.tiling.focused_frame.algorithm)
#echo ${${_layout:0:1}:u}


# check if script is already running
for pid in $(pidof -x "polybar_hlwm_handle_events.sh")
do
    if [[ $pid != $$ ]]
    then
        echo "[$(date)] : polybar_hlwm_handle_events.sh : Process is already running with PID $pid"
        exit 1
    fi
done


herbstclient --idle 2>/dev/null | {

    while read -A event
    do
        echo Hook 1
        echo processing event $event[1]
        herbstclient layout | rg "FOCUS"
        polybar-msg hook hlwm_layout 1

        echo Hook 2
        echo processing event $event[1]
        herbstclient tag_status
        polybar-msg hook hlwm_workspaces 1
    done

} 2>/dev/null

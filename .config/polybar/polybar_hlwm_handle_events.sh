#!/bin/zsh

typeset PROGNAME=$(basename $0)

# check if script is already running
for pid in $(pidof -x $PROGNAME)
do
    echo $pid
    if [[ $pid != $$ ]]
    then
        echo "[$(date)] : $PROGNAME: Process is already running with PID $pid"
        exit 1
    fi
done

TRAPTERM() {
        echo "[$(date)] : $PROGNAME stopped" >> /tmp/${PROGNAME}.log
        exit 0
}


herbstclient --idle | {

    while read -A event
    do
        if [[ ${event[1]} == "attribute_changed" ]]
        then
            polybar-msg hook hlwm_layout 1 1> /dev/null  2>&1
            sleep 0.1 # temp. fix to ensure next msg is processed by polybar
        fi

        if [[ ${event[1]} =~ "tag_" ]]
        then
            polybar-msg hook hlwm_workspaces 1 1> /dev/null  2>&1
            sleep 0.1 # temp. fix to ensure next msg is processed by polybar
        fi
    done

} 2>/dev/null

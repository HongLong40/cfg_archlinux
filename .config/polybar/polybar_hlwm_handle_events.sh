#!/bin/zsh

typeset PROGNAME=$(basename $0)
typeset PIDFILE="/tmp/polybar_hlwm_handle_events.pid"

# check if script is already running
if [[ -f $PIDFILE ]]
then
    pid=$(<${PIDFILE})

    if kill -0 $pid
    then
        echo "[$(date)] : $PROGNAME: Process is already running with PID $pid"
        exit 1
    fi
fi

# create pid file
echo $$ > $PIDFILE


TRAPHUP TRAPTERM() {
        echo "[$(date)] : $PROGNAME stopped" >> /tmp/${PROGNAME}.log
        rm -f $PIDFILE
        exit 0
}

herbstclient --idle | {

    while read -A event
    do
        if [[ ${event[1]} == "attribute_changed" ]]
        then
            polybar-msg action "#hlwm_layout.hook.0" 1> /dev/null  2>&1
            # polybar-msg hook hlwm_layout 1 1> /dev/null  2>&1
            # sleep 0.1 # temp. fix to ensure next msg is processed by polybar
        fi

        if [[ ${event[1]} =~ "tag_" ]]
        then
            polybar-msg action "#hlwm_workspaces.hook.0" 1> /dev/null  2>&1
            #polybar-msg hook hlwm_workspaces 1 1> /dev/null  2>&1
            # sleep 0.1 # temp. fix to ensure next msg is processed by polybar
        fi
    done

} 2>/dev/null

rm -f $PIDFILE


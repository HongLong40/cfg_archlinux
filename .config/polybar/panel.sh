#!/usr/bin/zsh

typeset SEMAPHORE="/tmp/polybar_started"

check_ok_to_start () {
    local pid=

    if [[ -f "$1" ]]
    then
        pid=$(<$1)

        if kill -0 $pid 2> /dev/null; then return 1; fi
    fi

    return 0
}


#if [[ -z $(pgrep -x polybar) ]]
if $(check_ok_to_start /tmp/polybar.pid)
then
    m=$(polybar --list-monitors | awk -F ":" '/primary/ { print $1 }')
    MONITOR=$m polybar --reload slate &
    echo $! > /tmp/polybar.pid

    rm -f $SEMAPHORE
    echo $(date "+%Y-%m-%d %T") polybar started > $SEMAPHORE
else    
    polybar-msg cmd restart
    notify-send -t 3000 -u low "Polybars Restarted"
    echo $(date "+%Y-%m-%d %T") polybar restarted >> $SEMAPHORE
fi


# start herbstclient idler for layout and workspace changes
if $(check_ok_to_start /tmp/polybar_hlwm_handle_events.pid)
then
    "$HOME/.config/polybar/polybar_hlwm_handle_events.sh" &
else
    echo Polybar event handler is already running
fi

# start dunst notification daemon if it has not already started
#if [[ ! $(pgrep -f dunst) ]]; then dunst & fi
#systemctl start --user dunst

# start pacman update monitoring script (used by polybar pacman script module)
if $(check_ok_to_start /tmp/check_pacman_updates.pid)
then
    "$HOME/.config/polybar/check_pacman_updates.sh" &
else
    sleep 10 # wait for polybar to be ready to receive messages
    polybar-msg action "#pacman_updates.hook.1"
fi


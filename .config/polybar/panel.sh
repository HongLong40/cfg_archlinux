#!/usr/bin/zsh

typeset SEMAPHORE="/tmp/polybar_started"

if [[ -z $(pgrep -x polybar) ]]
then
    m=$(polybar --list-monitors | awk -F ":" '/primary/ { print $1 }')
    MONITOR=$m polybar --reload slate &

    rm -f $SEMAPHORE
    echo $(date "+%Y-%m-%d %T") polybar started > $SEMAPHORE
else    
    polybar-msg cmd restart
    notify-send -t 3000 -u low "Polybars Restarted"
    echo $(date "+%Y-%m-%d %T") polybar restarted >> $SEMAPHORE
fi


# start herbstclient idler for layout and workspace changes
if [[ -z $(pidof -x "polybar_hlwm_handle_events.sh") ]]
then
    "$HOME/.config/polybar/polybar_hlwm_handle_events.sh" &
fi

# start dunst notification daemon if it has not already started
if ! pgrep -f dunst; then dunst &; fi

# start pacman update monitoring script (used by polybar pacman script module)
if  [[ -z $(pidof -x "check_pacman_updates.sh") ]]
then
    "$HOME/.config/polybar/check_pacman_updates.sh" &
else
    sleep 10 # wait for polybar to be ready to receive messages
    polybar-msg hook pacman_updates 2
fi


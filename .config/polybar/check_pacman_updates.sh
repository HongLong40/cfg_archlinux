#!/bin/zsh

typeset PROGNAME=$(basename $0)
typeset PIDFILE="/tmp/check_pacman_updates.pid"

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
echo "[$(date)] : $PROGNAME (${pid_main}) stopped" >> /tmp/${PROGNAME}.log
    rm -f /tmp/pacman_updates*
    rm -f $PIDFILE
    exit 0
}

TRAPUSR1() {
    write_log "refreshing update counts"
    kill $pid 2> /dev/null || true
}

# Defaults
typeset CONFIG=$HOME/.config/polybar/check_pacman_updates.config 
typeset LOG=$HOME/.config/polybar/check_pacman_updates.log

# define tracking variables
typeset -i last_update_count=-1
typeset -i curr_update_count=0
typeset -i counter=1

# define write_log function
write_log() { echo $(date "+%Y-%m-%d %T") "$@" >> $LOG }

#define check_update function
check_update() {
    _update_count_arch=$(checkupdates 2> /dev/null | sed 's/^/Arch /' > /tmp/pacman_updates | wc -l)
    _update_count_aur=$(paru -Qum 2> /dev/null | sed 's/^/AUR  /' >> /tmp/pacman_updates | wc -l)

    if [[ ( ${_update_count_arch} -eq 0 ) && ( ${_update_count_aur} -eq 0 ) ]]
    then
        echo - "-" > /tmp/pacman_updates.count
    else
        echo ${_update_count_arch}"."${_update_count_aur} > /tmp/pacman_updates.count
    fi
    
    curr_update_count=$(( $_update_count_arch + $_update_count_aur ))
    
    write_log "Update Count: ..$curr_update_count.."
    
    if [[ ($last_update_count -ne $curr_update_count) ]]
    then
        last_update_count=$curr_update_count
        polybar-msg action "#${pbc[hook_name]}.hook.${pbc[hook_id]}" || true
        if [[ $curr_update_count -ne 0 ]]; then
            notify-send -t 5000 "$curr_update_count Pacman Update(s) Available"
        fi
    fi
}


# initialize log
rm -f $LOG
write_log "Starting $PROGNAME with PID = $$"

# load parameters
typeset -A pbc=( $(<$CONFIG) )

write_log "Polling Interval = ${pbc[poll_interval]}"

# Wait for up to 15s, as polybars need to start up
while [[ (! -f /tmp/polybar_started) && $counter -le 15 ]]
do
    write_log "file not found $counter"
    sleep 1
    (( counter++ ))
done

# infinite loop: get updates count, update polybar, sleep until next cycle
while true
do
    check_update
    sleep ${pbc[poll_interval]} &
    pid=$!
    wait
done

# vim:ft=zsh:


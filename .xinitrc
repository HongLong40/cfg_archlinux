#!/bin/env zsh

# Load profile
for file in "/etc/profile" "$HOME/.profile" "/etc/xprofile" "$HOME/.xprofile"
do
    if [ -f "$file" ]
    then
        echo "Loading profile from $file";
        . "$file"
    fi
done

# Load resources
for file in "/etc/X11/Xresources" "$HOME/.Xresources"
do
    if [ -f "$file" ]
    then
        echo "Loading resource: $file"
        xrdb -merge "$file"
    fi
done

# Run all system xinitrc shell scripts
xinitdir="/etc/X11/xinit/xinitrc.d"
if [ -d "$xinitdir" ]
then
    for script in $xinitdir/*
    do
        echo "Loading xinit script $script"
        if [ -x "$script" -a ! -d "$script" ]
        then
            . "$script"
        fi
    done
fi

#/usr/bin/gnome-keyring-daemon --start --foreground --components=secrets &
#lxpolkit &

# start herbstluftwm. The --locked option eliminates flickering while wm starts
exec herbstluftwm --locked
#exec xmonad
#dbus-launch leftwm
# exec i3
#qtile start

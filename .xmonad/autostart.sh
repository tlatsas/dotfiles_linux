#!/bin/sh
#
# ~/.xmonad/autostart.sh
# startup programs


# X application settings
xrdb $HOME/.Xdefaults

# set background
nitrogen --restore &

# hide mouse when idle
unclutter -grab -idle 3 &

# launch xscreensaver - lock screen functionality
xscreensaver -nosplash &

# launch urxvt daemon
urxvtd -q -f -o

# set xmonad default cursor
xsetroot -cursor_name left_ptr

# merge clipboards
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

# start trayer
trayer  --edge bottom \
        --align right \
        --SetDockType true \
        --SetPartialStrut true \
        --expand false \
        --widthtype pixel \
        --width 137 \
        --transparent true \
        --alpha 0 \
        --tint 0x232323 \
        --height 17 &

# start conky top bar using dzen2
sh $HOME/.conky/dzenconkybar.sh &

# start pcmanfm in daemon mode (automatic devicee mounting)
#pcmanfm -d &

# start mpd as unpriviledged user if not already running
pgrep -x -u $(whoami) 'mpd' > /dev/null
[[ $? -eq '0' ]] && mpd ~/.mpd/mpd.conf > /dev/null 2>&1

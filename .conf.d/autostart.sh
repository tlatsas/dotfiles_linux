#!/bin/sh
#
# ~/.xmonad/autostart.sh
# settings - startup programs

# keyboard settings
setxkbmap -model evdev -layout us,gr -variant extended \
    -option grp:caps_toggle \
    -option grp_led:caps \
    -option eurosign:e \
    -option terminate:ctrl_alt_bksp \
    -option lv3:ralt_switch_multikey &

# X application settings
xrdb $HOME/.Xdefaults

# set background
nitrogen --restore &

# hide mouse when idle
#unclutter -idle 3 &

# launch urxvt daemon
urxvtd -q -f -o

# set xmonad default cursor
xsetroot -cursor_name left_ptr

# merge clipboards
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

# start trayer
trayer  --edge top \
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

# start mpd as unpriviledged user if not already running
pgrep -x -u $(whoami) 'mpd' > /dev/null
[[ $? -eq '1' ]] && mpd ~/.mpd/mpd.conf > /dev/null 2>&1

# automount
udiskie &

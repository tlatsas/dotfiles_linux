#!/bin/sh
#
# ~/.config/xinit-apps.sh

# we turn off keyboard backlight by default
kbd-backlight off &

# automount
udiskie &

# launch urxvt daemon
urxvtd -q -f -o

# set default cursor for Xmonad
xsetroot -cursor_name left_ptr

# set background
nitrogen --restore &

# merge clipboards
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

# keyboard layout settings
setxkbmap -model evdev -layout us,gr -variant extended \
    -option grp:caps_toggle \
    -option grp_led:caps \
    -option eurosign:e \
    -option terminate:ctrl_alt_bksp \
    -option lv3:ralt_switch_multikey &

# X application settings
xrdb $HOME/.Xdefaults

# grab dpi and make adjustmanets
_dpi=$(xdpyinfo |grep resolution|awk '{ print $2 }' | cut -f1 -d'x')
if [[ $_dpi -gt 96 ]]; then
    _height=26
else
    _height=17

    # smaller console fonts as the default font is 16px
    xrdb -merge - <(echo "URxvt*font: xft:DejaVu Sans Mono:pixelsize=12")
fi

# start trayer
# 168 dpi -> height=26
# 96 dpi -> height=17
trayer  --edge top \
        --align right \
        --SetDockType true \
        --SetPartialStrut true \
        --expand false \
        --widthtype percent \
        --width 10 \
        --transparent true \
        --alpha 0 \
        --tint 0x232323 \
        --height $_height &

# NM applet
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nm-applet >/dev/null 2>&1 &

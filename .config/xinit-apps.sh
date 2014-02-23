#!/bin/sh
#
# ~/.config/xinit-apps.sh
#
# background applications, utilities and settings when WM starts

# dependecies:
#   udiskie
#   urxvt
#   nitrogen
#   autocutsel
#   xorg apps: setxkbmap/xrdb/xdpyinfo/xsetroot
#   trayer
#   polkit-gnome
#   network manager applet

# automount
udiskie -s &

# launch urxvt daemon
urxvtd -q -f -o

# set default cursor for Xmonad
xsetroot -cursor_name left_ptr &

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
xrdb -quiet $HOME/.Xdefaults

# grab dpi and make adjustments on fonts and tray size
_dpi=$(xdpyinfo |grep resolution|awk '{ print $2 }' | cut -f1 -d'x')
if [ $_dpi -gt 96 ]; then
    _height=25
else
    _height=17
    # smaller console fonts as the default font is 16px
    xrdb -quiet -merge - <<< "URxvt*font: xft:DejaVu Sans Mono:pixelsize=12"
fi

# start trayer
# height:
#   168 dpi -> 26
#   166 dpi -> 25
#   96 dpi  -> 17
trayer --edge top \
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

# we turn off keyboard backlight by default
~/bin/kbd-backlight off &

# send the volume levels on this pipe
_volume_pipe=/tmp/.volume-pipe
[[ -p $_volume_pipe ]] || mkfifo $_volume_pipe
# send an initial value
~/bin/alsavol -p $_volume_pipe &

# init an mplayer socket to contol from cli
~/bin/mplayer-cmd 'init' &

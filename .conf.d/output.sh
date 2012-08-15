#!/bin/bash

# check if VGA is connected
if xrandr | grep -q 'VGA-0 connected'; then

    VgaRes=$(xrandr | grep -A 1 'VGA-0' | grep '\*' | awk '{ print $1 }')

    # if main monitor is connected turn off laptop display
    # assume that our main monitor has 1680x1050 resolution
    [[ $VgaRes == '1680x1050' ]] && xrandr --output LVDS-0 --off

fi

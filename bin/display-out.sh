#!/bin/bash
#
# Adjust screen resolution/DPI for external and laptop monitor after
# login depending on used driver

if lsmod | grep -q 'nouveau'; then
    if xrandr | grep -q 'VGA-1 connected'; then
        xrandr --output VGA-1 --mode 1680x1050 --rate 60 --dpi 90
    else
        # laptop screen - only adjust DPI
        xrandr --dpi 100
    fi
else
    # nvidia propriatary
    if xrandr | grep -q 'VGA-0 connected'; then
        # nvidia driver should pick the right resolution/rate for us
        xrandr --output VGA-0 --dpi 90
    else
        # laptop screen - only adjust DPI
        xrandr --dpi 100
    fi
fi

#!/bin/bash

#
# Switch to exernal monitor after login
#

# nvidia propriatary
res=$(xrandr | grep 'VGA-0' | awk '{ print $3 }' | cut -d'+' -f 1)
[[ $res == '1680x1050' ]] && xrandr --output LVDS-0 --off

# Nouveau
res=$(xrandr | grep 'VGA-1' | awk '{ print $3 }' | cut -d'+' -f 1)
[[ $res == '1366x768' ]] && xrandr --output LVDS-1 --off --output VGA-1 --auto

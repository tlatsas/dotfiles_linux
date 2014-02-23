#!/bin/bash
#
# Adjust screen resolution/DPI for external and laptop monitor after
# login depending on connected interfaces

is_external() {
    local external=(VGA-1 VGA-0 HDMI1)
    local iface
    for iface in "${external[@]}"; do
        [[ "$iface" == "$1" ]] && return 0
    done
    return 1
}

set_external() {
    xrandr --output eDP1 --off
    xrandr --output "$1" --mode 1680x1050 --dpi 96
}

set_laptop() {
    xrandr --dpi 166
}

for iface in $(xrandr | grep -w connected | cut -d' ' -f1); do
    if is_external $iface; then
        set_external $iface
        exit 2
    fi
done

set_laptop
exit 0

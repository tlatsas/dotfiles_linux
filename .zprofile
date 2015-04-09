#
# ~/.zprofile
#

# to log xinit messages use `startx &> /tmp/$UID-xlog` instead
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1

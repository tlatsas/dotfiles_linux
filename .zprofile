#
# ~/.zprofile
#

# to log xinit messages use `startx &> /tmp/$UID-xlog` instead
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx &> /dev/null

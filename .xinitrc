#!/bin/sh
# .xinitrc

# export dbus session
# (from /etc/X11/xinit/xinitrc.d/)
dbuslaunch="`which dbus-launch 2>/dev/null`"
if [ -n "$dbuslaunch" ] && [ -x "$dbuslaunch" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval `$dbuslaunch --sh-syntax --exit-with-session`
fi

# Gnome Keyring settings
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# adjust display if attached to main monitor
sh $HOME/bin/display-out.sh

# launch my apps
sh $XDG_CONFIG_HOME/xinit-apps.sh

exec xmonad

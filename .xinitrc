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

#
# GPG Agent settings
#
# start gpg agent with ssh support
#gnupginf="$HOME/.gnupg/gpg-agent.info"
#if pgrep -u $USER gpg-agent &>/dev/null; then
#  eval `cat $gnupginf`
#  eval `cut -d= -f1 $gnupginf | xargs echo export`
#else
#  eval `gpg-agent --enable-ssh-support --daemon --write-env-file $gnupginf`
#fi

# export gtkrc so qt applications are aware
export GTK2_RC_FILES=$HOME/.gtkrc-2.0

# pretty libreoffice
export OOO_FORCE_DESKTOP="gnome"

# tell matlab to use use system's jre
export MATLAB_JRE="/opt/java6/jre"

# AA fonts for Java applications
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

# we use a local folder for npm install -g
export _NODE="$HOME/.node"

# export other dirs containing executables
export PATH=$PATH:$HOME/bin:$_NODE/bin

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# export for python venv wrapper
export WORKON_HOME=$HOME/.virtualenvs

. $HOME/.bashrc

# adjust display if attached to main monitor
sh $HOME/bin/display-out.sh

# launch my apps
sh $XDG_CONFIG_HOME/xinit-apps.sh

exec xmonad

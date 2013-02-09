#
# ~/.bash_profile
#

#
# export dbus session
# (from /etc/X11/xinit/xinitrc.d/)
#
dbuslaunch="`which dbus-launch 2>/dev/null`"
if [ -n "$dbuslaunch" ] && [ -x "$dbuslaunch" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval `$dbuslaunch --sh-syntax --exit-with-session`
fi

#
# Gnome Keyring settings
#
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

# ruby gems - we install gems in user's folder by default
export GEM_HOME=$(ruby -rubygems -e "puts Gem.user_dir")

# tell matlab to use use system's jre
export MATLAB_JRE="/opt/java6/jre"

# AA fonts for Java applications
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

# export other dirs containing executables
export PATH=$PATH:$HOME/bin:$GEM_HOME/bin

. $HOME/.bashrc

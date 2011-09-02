# .xinitrc

# note: ck-launch-session moved in /etc/slim.conf
# -> login_cmd exec ck-launch-session /bin/bash -login ~/.xinitrc %session

# launch my apps
sh ${HOME}/.xmonad/autostart.sh > /dev/null 2>&1

# start xmonad awesomness
exec xmonad

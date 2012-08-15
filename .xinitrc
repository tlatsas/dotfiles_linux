# .xinitrc

# note: ck-launch-session moved in /etc/slim.conf
# -> login_cmd exec ck-launch-session /bin/bash -login ~/.xinitrc %session

# adjust display if attached to main monitor
sh $HOME/.conf.d/output.sh > /dev/null 2>&1

# launch my apps
sh $HOME/.conf.d/autostart.sh > /dev/null 2>&1

# start xmonad awesomness
exec xmonad

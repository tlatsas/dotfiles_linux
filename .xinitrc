# .xinitrc

# launch my apps
sh ${HOME}/.xmonad/autostart.sh > /dev/null 2>&1

# start xmonad awesomness
exec ck-launch-session dbus-launch --exit-with-session xmonad > /dev/null 2>&1


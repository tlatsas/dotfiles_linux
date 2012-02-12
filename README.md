dot..dot..dotfiles!


my setup
========
* xmonad (darcs)
* xmonad-contrib (darcs)
* xmobar
* trayer
* conky (with mpd support)
* dzen2 (with xft font support)
* nitrogen
* unclutter
* rxvt-unicode (with 256 color support)
* urxvt-url-select
* autocutsel
* mpd
* ncmpcpp
* scrot
* vim
* tmux
* udiskie
* lxdm
* slock


vim plugins
===========
all vim plugins are loaded by pathogen
plugins are in .vim/bundle as git submodules

install vim plugins
===================
After cloning the repo do:

$ git submodule init
$ git submodule update


then use the master branch:

$ git submodule foreach git checkout master


to update submodules do:

$ git submodule foreach git pull
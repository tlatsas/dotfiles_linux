Dotfiles
========

applications
------------
* xmonad (darcs)
* xmonad-contrib (darcs)
* xmobar
* trayer
* nitrogen
* rxvt-unicode (with 256 color support)
* urxvt-url-select
* autocutsel
* mpd
* ncmpcpp
* scrot
* vim
* ctags
* tmux
* udiskie
* lxdm
* slock


vim plugins
-----------
all vim plugins are loaded by pathogen
plugins are in .vim/bundle as git submodules

install vim plugins
-------------------
After cloning the repo:

```
$ git submodule init
$ git submodule update
```
To make sure you use the master branch you can do:
`$ git submodule foreach git checkout master`
And then update: `$ git submodule foreach git pull`

keep vim plugins up to date
---------------------------
Pull changes: `$ git submodule foreach git pull` and commit.

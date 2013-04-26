dotfiles
--------
System configuration files and scripts.


setup
-----

Main applications include:

* xmonad
* xmonad-contrib
* xmobar
* trayer
* nitrogen
* rxvt-unicode
* urxvt-perls
* autocutsel
* vim
* ctags
* tmux
* udiskie
* slock
* scrot
* gnome-keyring
* nm-applet

Other applications that help productivity:

* rbenv
* vault
* virtualenv
* latexmk

For style:

* zukitwo colors
* faenza dark icons
* xcursor-comix
* LS_COLORS for file colors in terminal

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


scripts / utilities
-------------------
Look into folder `bin`

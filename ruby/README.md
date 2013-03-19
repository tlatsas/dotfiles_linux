rbenv
-----

Rbenv and ruby-build are installed as git submodules in this directory.

* Link the ruby folder in your home directory.
* Append `~/ruby/bin` in your `$PATH` (we do not litter the ~/bin).
* Run `eval "$(rbenv init -)"` when your log in (put it in .xinitrc/.bash_profile/.whatever) [optional].

Rbenv data will live in ~/.rbenv. Upgrade using the usual git submodule magic.

# use British date/time format
export LC_TIME="en_GB.utf8"

# keychain
eval `/usr/bin/keychain --eval -Q -q --agents ssh,gpg`

# include bashrc
. $HOME/.bashrc

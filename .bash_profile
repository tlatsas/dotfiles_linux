# use British date/time format
export LC_TIME="en_GB.utf8"

# keychain
/usr/bin/keychain -Q -q --agents ssh,gpg

# include bashrc
. $HOME/.bashrc

# keychain
eval `/usr/bin/keychain --eval -Q -q --agents ssh,gpg`

# exports
[[ -f ${HOME}/.bash_inc/exports ]] && source ${HOME}/.bash_inc/exports

# include bashrc
source ${HOME}/.bashrc

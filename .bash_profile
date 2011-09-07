# keychain
eval `/usr/bin/keychain --eval -Q -q --agents ssh,gpg`

# exports
[[ -f ${HOME}/.bash.d/exports ]] && source ${HOME}/.bash.d/exports

# include bashrc
source ${HOME}/.bashrc

# keychain
#eval `/usr/bin/keychain --eval -Q -q --agents ssh,gpg`

# start gpg agent with ssh support
gnupginf="${HOME}/.gnupg/gpg-agent.info"
if pgrep -u "${USER}" gpg-agent >/dev/null 2>&1; then
  eval `cat $gnupginf`
  eval `cut -d= -f1 $gnupginf | xargs echo export`
else
  eval `gpg-agent --enable-ssh-support --daemon`
fi

# exports
[[ -f ${HOME}/.bash.d/exports ]] && source ${HOME}/.bash.d/exports

# include bashrc
source ${HOME}/.bashrc

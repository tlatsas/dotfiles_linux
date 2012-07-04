#
# ~/.bash_profile
#

# start gpg agent with ssh support
gnupginf="$HOME/.gnupg/gpg-agent.info"
if pgrep -u $USER gpg-agent &>/dev/null; then
  eval `cat $gnupginf`
  eval `cut -d= -f1 $gnupginf | xargs echo export`
else
  eval `gpg-agent --enable-ssh-support --daemon --write-env-file $gnupginf`
fi

# exports
[[ -f ~/.conf.d/exports ]] && source ~/.conf.d/exports

# include bashrc
source ~/.bashrc

export GTK2_RC_FILES=$HOME/.gtkrc-2.0
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export VAULT_PATH=$XDG_CONFIG_HOME/vault/vault.conf
export WORKON_HOME=$HOME/.virtualenvs

typeset -U path
path=(~/bin ~/.node/bin $path)

source /usr/bin/virtualenvwrapper.sh

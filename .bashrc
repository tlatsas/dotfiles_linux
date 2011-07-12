# Check for an interactive session
[ -z "$PS1" ] && return

# export gtkrc so qt applications are aware
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias lt='ls -lhrt' # sort by date
alias cls='clear'
alias ..='cd ..'
alias grep='grep --color=auto'
alias diff='colordiff'
alias diffy='colordiff -y --suppress-common-lines'
alias less='less -R'
alias ping='ping -c 5'
alias du='du -ch'
alias pss='ps axu'

# Archlinux specific aliases
alias pacman='pacman-color'
alias aur-update='yaourt -Su --aur'

# grep colors
export GREP_COLOR="0;33"

# use LS_COLORS from: https://github.com/trapd00r/LS_COLORS
if [ -f $HOME/.ls_colors ]; then
    eval $( dircolors -b $HOME/.ls_colors )
else
    eval $( dircolors -b )
fi

# enable bash completion in interactive shells
[[ -f /etc/bash_completion ]] && source /etc/bash_completion

# set the prompt
if [ -f $HOME/.bash_prompt ]; then
  . $HOME/.bash_prompt
else
  PS1='[\u@\h:\w]\$ '
fi

# Enable bash completition when preciding:
complete -cf sudo
complete -cf man
complete -cf which
complete -cf whereis
complete -cf locate
complete -cf slocate
complete -cf pgrep

# set the terminal title prompt
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

# append /usr/local/bin to PATH
export PATH=$PATH:/usr/local/bin

# set less colors for man pages
[[ -f $HOME/.less_colors ]] && source $HOME/.less_colors

# export vim editor
export EDITOR="/usr/bin/vim"

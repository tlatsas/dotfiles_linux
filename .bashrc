# If not running interactively, don't do anything (scp, rcp)
[[ $- != *i* ]] && return

#--[ shell parameters ]--------------------------------------------------------
set -o noclobber

#--[ Aliases ]-----------------------------------------------------------------

# navigate
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias lt='ls -lhrt' # sort by date
alias ..='cd ..'

# usability
alias grep='grep --color=auto'
alias diff='colordiff'
alias less='less -R'
alias ping='ping -c 5'
alias du='du -ch'

# safe options
alias cp='cp -i'
alias mv='mv -i'

# custom stuff
alias diffy='colordiff -y --suppress-common-lines'
alias cls='clear'
alias pss='ps aux'
alias unbloat='egrep -v "^$|^#"'
alias umnt='udiskie-umount'

# archlinux stuff
alias pacc='pacman-color'
alias pacman='/usr/bin/pacman'
alias aur-update='yaourt -Su --aur'

#--[ functions ]---------------------------------------------------------
vol() {
    amixer sget Master,0 | grep --color=never -o -m 1 '[[:digit:]]*%'
}

#--[ Includes / Prompts / Colors / Completion ]--------------------------------

# grep colors
export GREP_COLOR="0;33"

# use LS_COLORS from: https://github.com/trapd00r/LS_COLORS
if [[ -f $HOME/.bash.d/LS_COLORS ]]; then
    eval $( dircolors -b $HOME/.bash.d/LS_COLORS )
else
    eval $( dircolors -b )
fi

# enable bash completion in interactive shells
[[ -f /etc/bash_completion ]] && source /etc/bash_completion

# set the terminal title prompt
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

# prompt
if [[ "$TERM" = "linux" ]];then
    # awesome colors and simple prompt in virtual console
    [[ -f $HOME/.bash.d/vt ]] && source $HOME/.bash.d/vt
    unset PROMPT_COMMAND
    PS1='(\l) [\u@\h:\w]\$ '
else
    # fancy prompt
    if [[ -f $HOME/.bash.d/bash_prompt ]]; then
      . $HOME/.bash.d/bash_prompt
    else
      PS1='[\u@\h:\w]\$ '
    fi
fi

# set less colors for man pages
[[ -f $HOME/.bash.d/less_colors ]] && source $HOME/.bash.d/less_colors

# Enable bash completition when preciding:
complete -cf sudo
complete -cf man
complete -cf which
complete -cf whereis
complete -cf locate
complete -cf slocate
complete -cf pgrep

# If not running interactively, don't do anything (scp, rcp)
[[ $- != *i* ]] && return


#--[ Aliases ]-----------------------------------------------------------------

# navigate
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias lt='ls -lhrt' # sort by date
alias ..='cd ..'

# more usability
alias grep='grep --color=auto'
alias diff='colordiff'
alias less='less -R'
alias ping='ping -c 5'
alias du='du -ch'

# custom stuff
alias diffy='colordiff -y --suppress-common-lines'
alias cls='clear'
alias pss='ps aux'
alias unbloat='egrep -v "^$|^#"'

# archlinux stuff
alias pman='pacman-color'
alias pacman='/usr/bin/pacman'
alias aur-update='yaourt -Su --aur'

#--[ small functions ]---------------------------------------------------------

myip() {
    links -dump http://automation.whatismyip.com/n09230945.asp | tr -d ' '
}

spell() {
    echo $@ | hunspell -a  | sed '1d' | awk -F ': ' '{ print $2 }'
}

vol() {
    amixer sget Master,0 | grep --color=never -o -m 1 '[[:digit:]]*%'
}

#--[ Exports ]-----------------------------------------------------------------

# grep colors
export GREP_COLOR="0;33"

# export gtkrc so qt applications are aware
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# export vim editor
export EDITOR="/usr/bin/vim"

# gtk look for libreoffice
export OOO_FORCE_DESKTOP="gnome"

# manage paths
export GEM_HOME=${HOME}/.gems-local
export PATH=${PATH}:/usr/local/bin:${HOME}/.bin:${GEM_HOME}/bin


#--[ Includes / Prompts / Colors / Completion ]--------------------------------

# use LS_COLORS from: https://github.com/trapd00r/LS_COLORS
if [[ -f $HOME/.bash_inc/LS_COLORS ]]; then
    eval $( dircolors -b $HOME/.bash_inc/LS_COLORS )
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
    [[ -f $HOME/.bash_inc/vt ]] && source $HOME/.bash_inc/vt
    PS1='(\l) [\u@\h:\w]\$ '
else
    # fancy prompt
    if [[ -f $HOME/.bash_inc/bash_prompt ]]; then
      . $HOME/.bash_inc/bash_prompt
    else
      PS1='[\u@\h:\w]\$ '
    fi
fi

# set less colors for man pages
[[ -f $HOME/.bash_inc/less_colors ]] && source $HOME/.bash_inc/less_colors

# Enable bash completition when preciding:
complete -cf sudo
complete -cf man
complete -cf which
complete -cf whereis
complete -cf locate
complete -cf slocate
complete -cf pgrep

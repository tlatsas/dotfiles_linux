#
# ~/.bashrc
#

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
alias cower='cower -t ~/pkgs --color=always'

# safe options
alias cp='cp -i'
alias mv='mv -i'

# custom stuff
alias diffy='colordiff -y --suppress-common-lines'
alias cls='clear'
alias pss='ps aux'
alias unbloat='egrep -v "^$|^#"'
alias umnt='udiskie-umount -s'
alias lsd='ls -d */'
alias lsf='find . -maxdepth 1 -type f | cut -c 3- | sort'
alias cwd='pwd | tr -d "\n" | xclip'

#--[ Includes / Prompts / Colors / Completion ]--------------------------------

# grep colors
export GREP_COLOR="0;33"

# use LS_COLORS from: https://github.com/trapd00r/LS_COLORS
if [[ -f ~/.conf.d/LS_COLORS ]]; then
    eval $(dircolors -b ~/.conf.d/LS_COLORS)
else
    eval $(dircolors -b)
fi

# set the terminal title prompt
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

# prompt
if [[ "$TERM" = "linux" ]];then
    # awesome colors and simple prompt in virtual console
    [[ -f ~/.conf.d/vt ]] && source ~/.conf.d/vt
    unset PROMPT_COMMAND
    PS1='(\l) [\u@\h:\w]\$ '
else
    # fancy prompt
    if [[ -f ~/.conf.d/bash_prompt ]]; then
      source ~/.conf.d/bash_prompt
    else
      PS1='[\u@\h:\w]\$ '
    fi
fi

# set less colors for man pages
[[ -f ~/.conf.d/less_colors ]] && source ~/.conf.d/less_colors

# Enable bash completition when preciding:
complete -cf sudo
complete -cf man
complete -cf which
complete -cf whereis
complete -cf locate
complete -cf slocate
complete -cf pgrep

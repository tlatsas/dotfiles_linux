#
# ~/.bashrc
#

# If not running interactively, don't do anything (scp, rcp)
[[ $- != *i* ]] && return

set -o noclobber

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias lt='ls -lhrt' # sort by date
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias diff='colordiff'
alias less='less -R'
alias ping='ping -c 5'
alias du='du -ch'
alias fjson="python -m json.tool"
alias fxml="xmllint --format -"
alias cp='cp -i'
alias mv='mv -i'
alias diffy='colordiff -y --suppress-common-lines'
alias cls='clear'
alias pss='ps aux'
alias unbloat='egrep -v "^$|^#"'
alias umnt='udiskie-umount -s'
alias lsd='ls -d */'
alias lsf='find . -maxdepth 1 -type f | cut -c 3- | sort'
alias cwd='pwd | tr -d "\n" | xclip'
alias lanscan='sudo nmap -PE -sn -n'
alias pacclear='sudo pacman -Scc'
alias rand='openssl rand -base64 45'
alias xev='xev | grep -A2 --line-buffered "^KeyRelease" | sed -n "/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p"'
alias v='viewnior'
alias wg='curl -O'
alias cower='_cower_run_tmp'
alias upshot='_vps_upload'

alias rails='bundle_exec rails'
alias rspec='bundle_exec rspec'
alias guard='bundle_exec guard'
alias rake='bundle_exec rake'
alias npmg='npm install --prefix ~/.node/ -g'
alias venvon='source /usr/bin/virtualenvwrapper.sh'

bundle_exec() {
    if [[ -f ./Gemfile ]]; then
        echo ":: Running command with 'bundle exec'"
        bundle exec "$@"
    else
        "$@"
    fi
}

map() { while read l; do $@ "$l"; done; }

_cower_run_tmp() {
    local target=/tmp/pkg
    [[ -d $target  ]] || mkdir $target
    /usr/bin/cower -t $target --color=always $@
}

_vps_upload() {
    scp "$@" "dione:~/http/misc/"
    echo "https://dl.kodama.gr/misc/$@"
}


vimconflicts() {
    vim +/"<<<<<<<" $( git diff --name-only --diff-filter=U | xargs )
}

# autocomplete vault
which vault > /dev/null && . "$( vault --initpath )"

# grep colors
export GREP_COLOR="0;33"

# bash history
export HISTCONTROL=ignoredups

# git prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

export EDITOR="/usr/bin/vim"
export VAULT_PATH="${HOME}/.config/vault/vault.conf"

# use LS_COLORS from: https://github.com/trapd00r/LS_COLORS
if [[ -f ~/lib/LS_COLORS/LS_COLORS ]]; then
    eval $(dircolors -b ~/lib/LS_COLORS/LS_COLORS)
else
    eval $(dircolors -b)
fi

# set the terminal title prompt
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

# set bash prompt function
_set_prompt() {
    # color codes
    local txtrst='\[\e[0m\]'    # Text Reset
    local txtblu='\[\e[0;34m\]' # Blue
    local txtcyn='\[\e[0;36m\]' # Cyan
    local txtred='\[\e[0;31m\]' # Red
    local txtgrn='\[\e[0;32m\]' # Green
    local txtylw='\[\e[0;33m\]' # Yellow
    local txtmag='\[\e[0;35m\]' # magenta
    local bldred='\[\e[1;31m\]' # Red Bold
    local bldgrn='\[\e[1;32m\]' # Green Bold
    local bldgra='\[\e[0;37m\]' # Gray Bold
    local bldcyn='\[\e[1;36m\]' # Cyan Bold

    # workaround bash-completion issues
    #_xfunc git __git_ps1 &>/dev/null

    # check if git ps1 function is declared
    #type -t __git_ps1 &>/dev/null

    . /usr/share/git/git-prompt.sh

    # show git info
    if [[ $? -eq 0 ]]; then
        local _gp="$txtmag"'$(__git_ps1 "( %s )" )'"$txtrst"
    else
       local _gp=''
    fi

    #set PS1
    PS1=" $bldgra¦ $bldcyn\w$txtrst $_gp\n"

    if [[ $(id -u) -eq 0 ]]; then
       PS1="\n$bldred\u$txtrst"$PS1"$txtred>$bldred>$txtrst "
    else
       PS1="\n$bldgrn\u$txtrst"$PS1"$txtgrn>$bldgrn>$txtrst "
    fi
}

_set_vt() {
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white

    clear
}

# prompt
if [[ "$TERM" = "linux" ]];then
    # set vt console colors
    _set_vt
    unset PROMPT_COMMAND
    PS1='(\l) [\u@\h:\w]\$ '
else
    # bash prompt
    _set_prompt
fi

_set_man_colors() {
    ## Red-Green Color Scheme
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;44;33m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'

    ## Blue-Magenta Color Scheme
    #export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
    #export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
    #export LESS_TERMCAP_me=$'\E[0m'           # end mode
    #export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
    #export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
    #export LESS_TERMCAP_ue=$'\E[0m'           # end underline
    #export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
}
_set_man_colors

# If not running interactively, don't do anything (scp, rcp)
[[ $- != *i* ]] && return

set -o noclobber

setopt appendhistory
setopt share_history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -U compinit
compinit

[[ -n "${key[PageUp]}"   ]] && bindkey "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]] && bindkey "${key[PageDown]}" history-beginning-search-forward

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
alias unbloat='egrep -v "^#|^;|^[[:space:]]*$"'
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

# vault
export VAULT_PATH=$HOME/.config/vault/vault.conf
which vault &> /dev/null && . "$( vault --initpath )"

# chruby / ruby install
source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh

# use LS_COLORS from: https://github.com/trapd00r/LS_COLORS
if [[ -f ~/lib/LS_COLORS/LS_COLORS ]]; then
    eval $(dircolors -b ~/lib/LS_COLORS/LS_COLORS)
else
    eval $(dircolors -b)
fi

# set the terminal title prompt
#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

# set bash prompt function
_set_prompt() {
    autoload -U zsh/terminfo
    autoload -U colors && colors

    # make some aliases for the colours: (coud use normal escap.seq's too)
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
        eval PR_$color='%{$fg[${(L)color}]%}'
        eval PR_${color}_B='%{$fg_bold[${(L)color}]%}'
    done
    PR_RST="%{$terminfo[sgr0]%}"

    # git prompt
    source /usr/share/git/git-prompt.sh
    setopt prompt_subst
    p_git='$(__git_ps1 "( %s )" )'

    PS1=" $PR_WHITE¦ $PR_CYAN_B%~$PR_RST $PR_MAGENTA$p_git$PR_RST"

    # ugly indentation for multi-line prompts!
    if [[ $UID -eq 0 ]]; then
       PS1="$PR_RED_B%n$PR_RST$PS1
$PR_RED>$PR_RED_B>$PR_RST "
    else
       PS1="$PR_GREEN_B%n$PR_RST$PS1
$PR_GREEN>$PR_GREEN_B>$PR_RST "
    fi
}
_set_prompt

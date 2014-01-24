# If not running interactively, don't do anything (scp, rcp)
[[ $- != *i* ]] && return

set -o noclobber
bindkey -e

HISTFILE=$HOME/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

bindkey '\e[1~' beginning-of-line
bindkey '\e[2~' overwrite-mode
bindkey '\e[3~' delete-char
bindkey '\e[4~' end-of-line
bindkey '\e[5~' up-line-or-history
bindkey '\e[6~' down-line-or-history
bindkey '^?' backward-delete-char
bindkey '\e[D' backward-char
bindkey '\e[C' forward-char
# for rxvt
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
# for gnome-terminal
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line

autoload -U compinit
compinit

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
alias umnt='udiskie-umount'
alias lsd='ls -d */'
alias lsf='find . -maxdepth 1 -type f | cut -c 3- | sort'
alias cwd='pwd | tr -d "\n" | xclip'
alias lanscan='sudo nmap -PE -sn -n'
alias pacclear='sudo pacman -Scc'
alias rand='openssl rand -base64 45'
alias xev='xev | grep -A2 --line-buffered "^KeyRelease" | sed -n "/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p"'
alias v='viewnior'
alias wg='curl -O'
alias cower='_cower_tmpfs'
alias upshot='_vps_upload'
alias h='history'
alias h\?='history | grep -i '
alias serve='python -m http.server $@'
alias serve2='python -m SimpleHTTPServer $@'
alias last='last -a | head -15'

alias rails='bundle_exec rails'
alias rspec='bundle_exec rspec'
alias guard='bundle_exec guard'
alias rake='bundle_exec rake'
alias npm='npm --prefix ~/.node'

bundle_exec() {
    if [[ -f ./Gemfile ]]; then
        echo ":: Running command with 'bundle exec'"
        bundle exec "$@"
    else
        "$@"
    fi
}

map() { while read l; do $@ "$l"; done; }

_cower_tmpfs() {
    local target=/tmp/pkg
    [[ ! -d $target  ]] && mkdir $target
    /usr/bin/cower $@
}

_vps_upload() {
    scp "$@" "dione:~/http/misc/"
    echo "https://dl.kodama.gr/misc/$@"
}

vimconflicts() {
    vim +/"<<<<<<<" $( git diff --name-only --diff-filter=U | xargs )
}

# vault
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

# travis-ci cli completion
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

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

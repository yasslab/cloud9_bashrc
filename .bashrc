# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

. /etc/apache2/envvars

# If not running interactively, don't do anything else
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#PS1='\[\033[01;32m\]${C9_USER}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)") $ '
PS1="╭─○ \[\033[01;32m\]${C9_USER}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")
╰─○ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export rvm_silence_path_mismatch_check_flag=1

# Enable peco for Ctrl-r
export PATH="$PATH:~/bin"

peco-select-history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco-select-history'

#alias hub-pr="hub pull-request | open"
#alias git="hub"
alias ping-loop="while true; do ping www.google.com; sleep 3; done;"
alias gommit="git commit"
alias tag-gen="ripper-tags -e -R -f TAGS"
alias h="heroku"

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lv="less"

alias e="emacs -nw"
alias g="git"
alias ga="git add -A"
alias gc="git commit -m"
alias gp="git push"
#alias gs="git status"
alias gd="git diff"
alias gl="git log --pretty='format:%Cblue[%ad] %Cgreen%an %Creset%s' --date=short"
alias gr="git remote -v"
alias v="vim"
alias r="rails"
alias bi="bundle install"
alias be="bundle exec"

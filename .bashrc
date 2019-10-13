# .bashrc

export PATH=$PATH:$HOME/.local/bin:$HOME/bin

# load nvm
export NVM_DIR="$HOME/.nvm"
[ "$BASH_VERSION" ] && npm() { 
    # hack: avoid slow npm sanity check in nvm
    if [ "$*" == "config get prefix" ]; then which node | sed "s/bin\/node//"; 
    else $(which npm) "$@"; fi 
}
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
rvm_silence_path_mismatch_check_flag=1 # prevent rvm complaints that nvm is first in PATH
unset npm # end hack


# User specific aliases and functions
alias python=python3.6

# modifications needed only in interactive mode
if [ "$PS1" != "" ]; then
    # Set default editor for git
    git config --global core.editor /usr/bin/nano

    # Turn on checkwinsize
    shopt -s checkwinsize

    # keep more history
    shopt -s histappend
    export HISTSIZE=100000
    export HISTFILESIZE=100000
    export PROMPT_COMMAND="history -a;"

    # Source for Git PS1 function
    git_type=$(type -t __git_ps1)
    if [ -z $git_type ] && [ -e "/usr/share/git-core/contrib/completion/git-prompt.sh" ]; then
        . /usr/share/git-core/contrib/completion/git-prompt.sh
    fi

    # Cloud9 default prompt
    _cloud9_prompt_user() {
        if [ "$C9_USER" = root ]; then
            echo "$USER"
        else
            echo "$C9_USER"
        fi
    }

    git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    }
    git_color() {
        [[ -n $(git status --porcelain=v2 2>/dev/null) ]] && echo 31 || echo 33
    }

    # PS1='\[\033[01;32m\]$(_cloud9_prompt_user)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)" 2>/dev/null) $ '
    #PS1="╭─○ \[\033[01;32m\]${C9_USER}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")╰─○ "
    PS1="╭─○ \[\033[\$(git_color)m\]\$(git_branch)\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")
╰─○ "
fi

[[ -s "$HOME/.rvm/environments/default" ]] && source "$HOME/.rvm/environments/default"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# .bashrc settings from GitHub
# https://github.com/yasslab/cloud9_bashrc

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

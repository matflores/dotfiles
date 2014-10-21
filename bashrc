# ~/.bashrc executed by bash for non-login shells.

# configure history
HISTCONTROL=ignoredups
HISTSIZE=500
HISTFILESIZE=500

# append to the history file instead of overwriting it
shopt -s histappend

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   username@Machine ~/dev/dir[master]$   # clean working directory
#   username@Machine ~/dev/dir[master*]$  # dirty working directory

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

_gs_ps1() {
  [[ -z $GS_NAME ]] || echo "[$GS_NAME] "
}

export PS1="\n\[\033[01;32m\]\w \[\033[1;33m\]\$(_gs_ps1)\[\033[01;31m\]\$(parse_git_branch \"(%s) \")\[\033[01;36m\]>>\[\033[00m\] "
export PS1="\[\033[G\]$PS1"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export CLICOLOR=1
export LSCOLORS=GxBxhxDxfxhxhxhxhxcxcx

# enable bash completion
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

#Alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# enable git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# define internationalization variables
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=/usr/local/bin:/usr/local/Cellar/ruby/1.9.3-p194/bin:$PATH
export CDPATH=~/src:~/src/aw:~/src/cb:~/src/rb:~/src/js:~/src/etc:$CDPATH
export EDITOR=emacs

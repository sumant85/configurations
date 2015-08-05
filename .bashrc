PATH=$PATH:/usr/local/mysql/bin:/Applications/android-sdk-macosx/platform-tools/

# AWS SETUP
#export AWS_CONFIG_FILE='/Users/sumant/.aws_credentials'
#export LANG=en_US.utf-8
#export LC_ALL=en_US.utf-8
#export BOTO_PATH=/Users/sumant/.boto/boto.cfg

# AWS SETUP
#export AWS_ACCESS_KEY_ID=...
#export AWS_SECRET_ACCESS_KEY=...

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

set -o vi

# Backward and forward search using arrow keys.
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# Loop through files using tab
# bind '"\t":menu-complete'

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000000
HISTFILESIZE=20000000000
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
PS1="$PS1\n_ "

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


export EDITOR='/usr/bin/vim'

# GIT completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# AWS completion
complete -C aws_completer aws

# Converts timestamp string in millis to date
function ts()
{
  str="$1"
  date -r ${str:0:10}
}

function clearvlc()
{
defaults write org.videolan.vlc NSRecentDocumentsLimit 0;
defaults delete org.videolan.vlc.LSSharedFileList RecentDocuments;
defaults write org.videolan.vlc.LSSharedFileList RecentDocuments -dict-add MaxAmount 0;
}

function gslf()
{
 git diff-tree --no-commit-id --name-only -r $1
}

# aliases
alias c='clear'
alias stripws='sed -i "" -E "s/[[:space:]]*$//"'
alias s3pp='s3cmd put --acl-public'
alias copy='rsync -aP'
alias camelToUnderscore='sed -r "s/([a-z]+)([A-Z][a-z]+)/\1_\l\2/g"'
alias cdg='cd $GIT_ROOT'
alias gc='git checkout'
alias gs='git status -uno'
alias gl='git log --pretty=oneline -5'
alias deploy_api_preprod='./build_eb_package.sh -c config_preprod -p credentials_preprod'
alias deploy_api_prod='./build_eb_package.sh -c config -p credentials'
alias change_mac='sudo ifconfig en0 ether `openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//"`'

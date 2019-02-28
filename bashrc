function is_prog_on_path () {
    if [[ $# -ne 1 ]]; then
        echo "Bash function usage: is_prog_on_path <some_program_name> # to determine if some_program_name is on path" 1>&2
        exit 1
    fi
    hash $1 &> /dev/null
    return $?
}

###############
# Terminal type
###############
# Fix 'Unknown terminal type' err when ssh from rxvt terminal
export TERM='xterm-256color'


########
# Prompt
########
# Abbreviate long paths in prompt
PROMPT_DIRTRIM=3


#######
# Paths
#######
# Add user-specific bin and lib dirs to path
[[ -d $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -d $HOME/lib ]] && export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH
[[ -d $HOME/Dropbox/bin  ]] && export PATH=$HOME/Dropbox/bin:$PATH


########
# Editor
########
if is_prog_on_path nvim; then
    export EDITOR=nvim
    alias vi=nvim
    alias vimdiff='nvim -d'
elif is_prog_on_path vim; then
    export EDITOR=vim
    alias vi=vim
    alias vmi=vim
else
    export EDITOR=vi
fi

# vim without any user config
alias vout="\vim -u NONE -U NONE -N -i NONE -c 'syntax on'"

# Emacs without GUI
#alias emacs='emacs -nw'


#########
# Browser
#########
if [ -n "$DISPLAY" ]; then
    if is_prog_on_path firefox; then
        export BROWSER=firefox
    fi
else 
    if is_prog_on_path w3m; then
        export BROWSER=firefox
    elif is_prog_on_path elinks; then
        export BROWSER=elinks
    fi
fi

export WWW_HOME='https://duckduckgo.com'


####
# ls
####
# Disable coloured output in HPC environments to reduce stat calls on Lustre filesystems
if [[ -n $SGE_ROOT ]]; then
    alias ls='ls --color=never'
else
    alias ls='ls --color=auto'
fi


######
# grep
######
# Enable coloured output
alias grep='grep --color=auto'


######
# diff
######
# Enable coloured output
grep -iq arch /etc/issue && alias diff='diff --color=auto'


########
# Paging
########
# Set preferred pager...
export PAGER='less'
# ... and enable colour output (output ANSI "color" escape sequences)
export LESS='-R'


######
# Info
######
# Use vi/less bindings for info
alias info='info --vi-keys'


#####
# SSH
#####
# Define agent socket location
#if [ -n "${XDG_RUNTIME_DIR}" ] && [ -z "$SSH_AUTH_SOCK" ]; then
#    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
#fi


#####
# GPG 
#####
# If our TTY is not controlled by SSH i.e. is local:
if [ -z ${SSH_TTY+x} ] && [ -z ${SSH_CLIENT+x} ] ; then
    # Want to use gpg-agent instead of OpenSSH agent as ssh agent
    unset SSH_AGENT_PID
    # Determine the ssh-agent socket
    if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
    export GPG_AGENT_INFO="${SSH_AUTH_SOCK}"
    # Set the GPG_TTY and refresh the TTY in case user has switched into an X session as stated in gpg-agent(1):
    export GPG_TTY=$(tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null
fi


########################
# Open using default app
########################
# Quick way of opening file using default apps 
# (see ~/.config/mimetypes.list to customise
if is_prog_on_path gio; then
    alias ]='gio open'
elif is_prog_on_path xdg-open; then
    alias ]='xdg-open'
fi


#########
# Modules
#########
# Define some convenient aliases if we're using Modules but don't have Lmod
if [[ -n ${MODULESHOME+x} ]] && ! $(module --version 2>&1 | grep -wq Lua); then 
    alias ma='module avail -t 2>&1'
    alias ml='module load'
    alias mu='module unload'
    alias ms='module show'
    alias mp='module purge'
fi


###########
# Clipboard
###########
# Aliases for writing to / reading from clipboard
if [[ -n ${DISPLAY+x} ]] && is_prog_on_path xclip; then 
    alias getclip='xclip -selection clipboard -in'
    alias setclip='xclip -selection clipboard -out'
fi


##################
# Input device cfg
##################
if [[ -n ${DISPLAY+x} ]]; then
    if is_prog_on_path setxkbmap; then
        # Set the compose key to right alt
        setxkbmap -option compose:ralt
        # Er, what does this do???
        setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll gb
    fi
    # Disable 'tap to click' on touchpad
    if is_prog_on_path synclient && $(xinput list | grep -q "Synaptics"); then
        synclient MaxTapTime=0
    fi
fi


#####
# Git
#####
# Add git status info to bash prompt using
GIT_PROMPT_DIR="${HOME}/.bash-git-prompt/"
[[ -d ${GIT_PROMPT_DIR} ]] || git clone https://github.com/magicmonty/bash-git-prompt.git ${GIT_PROMPT_DIR}
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
GIT_PROMPT_START=$(hostname)    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence
source "${GIT_PROMPT_DIR}/gitprompt.sh"

GIT_SUBREPO_DIR="${HOME}/.git_subrepo_dir/"
[[ -d ${GIT_SUBREPO_DIR} ]] || git clone https://github.com/ingydotnet/git-subrepo  ${GIT_SUBREPO_DIR}
source "${GIT_SUBREPO_DIR}/.rc"

# Use 'hub' (https://github.com/github/hub) for interacting with GitHub from command-line
is_prog_on_path hub && eval $(hub alias -s)


########
# Python
########
# Env vars for virtualenvwrapper
export WORKON_HOME=$HOME/.venvs
export PROJECT_HOME=$HOME/dev

# Reduce console noise when generating PySide figs using matplotlib
export QT_ACCESSIBILITY=0 

# Activate / deactivate conda envs
alias cae='. activate'
alias cde='. deactivate'

# Dir for storing Python wheels (packages)
if [[ -f /etc/lsb-release ]]; then
    source /etc/lsb-release
    export WHEELHOUSE="/home/will/dev/wheelhouse/$DISTRIB_ID$DISTRIB_RELEASE"
fi

# PySpark environment vars
export PYSPARK_PYTHON=python3 
export PYSPARK_DRIVER_PYTHON=ipython 
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"


####
# Go
####
export GOPATH=$HOME/dev/go
[[ -d $GOPATH/bin ]] || mkdir -p $GOPATH/bin
export PATH=$GOPATH/bin:$PATH


#########
# C / C++
#########
# Add CCache dir to path
export PATH=/usr/lib/ccache:${PATH}

# Default ctags options for C code
alias ctags='ctags --c-kinds=cdfgmnstu'


##############
# Ruby / rbenv
##############
is_prog_on_path rbenv && eval "$(rbenv init -)"


##################
# FZF fuzzy finder
##################
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash


#########
# Haskell
#########
# Use user-installed cabal in preference to system cabal
CABALDIR="$HOME/.cabal/bin"
[[ -d $CABALDIR ]] && export PATH=$CABALDIR:$PATH


#########
# Tcl
#########
if is_prog_on_path rlwrap && is_prog_on_path tclsh; then
    alias tclsh='rlwrap -c tclsh'
fi


###########
# Passwords
###########
alias mypwgen='pwgen -BcnyC 12 10'


##########
# Todo.txt
##########
# (largely redundant now migrated to taskwarrior)
alias t="$EDITOR $HOME/Dropbox/todotxt/{todo.txt,waiting.txt,parked.txt,sdm.txt,done.txt}"
# completion for todo.sh (todo.txt cli)
complete -F _todo t  


#######
# Music
#######
# Alias for best mpd client
alias m=ncmpcpp

# Calculate the bitrate of MP3 files
alias mp3bitrate='mp3info -r a -p "%f %r\n"'


#########
# Ansible
#########
# Disable Ansible's use of cowsay
export ANSIBLE_NOCOWS=1


#####
# IPs
#####
# University of Sheffield IP for DNS fault-finding
export UOSWEB_IP=143.167.2.102


#############
# Krita HiDPI
#############
export KRITA_HIDPI=ON


####################
# Firefox HiDPI mode
####################
alias firefox-hidpi='GDK_SCALE=2 GDK_DPI_SCALE=1 firefox'


#######
# Email
#######
# Mutt
if is_prog_on_path neomutt; then
    mutt_prog=neomutt
else
    mutt_prog=mutt
fi
[[ -n ${mutt_prog+x} ]] && alias persgm="${mutt_prog} -F ${HOME}/.mutt/muttrc.persgm"
unset mutt_prog

# Vim config for standalone reading/writing of email content
alias vimail='vi -c "set spell spelllang=en" -c "set filetype=mail"' #-c "set tw=72" 


#################
# Handy functions
#################

# Find non-ASCII chars in file
function find-non-ascii() {
    if [[ $# -ne 1 ]]; then
        echo "Bash function usage: find-non-ascii <some-file>  # find non-ascii chars in a file" 1>&2
        return 1
    fi
    local -r _fname=$1
    grep --color='auto' -P -n "[\x80-\xFF]" "${_fname}"
}

# Get env var value for particular PID
function env-var-for-pid() {
    if [[ $# -ne 2 ]]; then
        echo "Get value of env var defined for process when process started; usage: env-var-for-pid <process_id> <env_var_name>" 1>&2
        return 1
    fi
    local -r _pid=$1
    local -r _var=$2
    xargs --null --max-args=1 echo < /proc/${_pid}/environ | awk -F= "/^${_var}=/ {print \$2}"
}

# Reverse DNS using drill
function drill-rdns () {
    if [[ $# -ne 1 ]]; then
        echo "Reverse DNS lookup using drill.  Usage: drill-rns some_ip_address" 1>&2
        return 1
    fi
    local -r _ipaddr=$1
    drill -x $_ipaddr | grep PTR | tac | head -n 1 | cut -d '' -f5
}

# grep backwards
function grepb () {
    if [[ $# -ne 2 ]]; then
        echo "Grep backwards (without buffering).  Usage: grepb somepattern somefile" 1>&2
        return 1
    fi
    tac $2 | stdbuf -o0 grep $1
}

# Is port open? (pure bash)
function is-port-open () {
    if [[ $# -ne 2 ]]; then
        echo "Check if a port is open using: is-port-open hostname port" 1>&2
        return -1
    fi
    local -r _host=$1 
    local -r _port=$2 
    timeout 1 bash -c "cat < /dev/null > /dev/tcp/${_host}/${_port}" 2>/dev/null && echo "port ${_port} is open" || echo "port ${_port} is closed"
}

# Allocate and use x MB of RAM
# (inspired by http://unix.stackexchange.com/a/254976)
function memalloc () {
    echo $#
    if [[ $# -ne 1 ]]; then
        echo "usage: memalloc X, where X is the number of MB to allocate" 1>&2
        return -1
    fi
    local -r n_MB=$1
    yes | tr \\n x | head -c $(($n_MB * 1024 * 1024)) | grep n
}

function clang-format-custom () {
    # (from https://matt.sh/howto-c)
    # clang-format is the best automatic C formatter as of 2016: best defaults and actively developed
    # 
    # Run using cleanup-format-custom -i *.{c,h,cc,cpp,hpp,cxx}
    # 
    # NB -i overwrites existing files in place with formatting changes instead of writing to new files or creating backup files.
    clang-format -style="{BasedOnStyle: llvm, IndentWidth: 4, AllowShortFunctionsOnASingleLine: None, KeepEmptyLinesAtTheStartOfBlocks: false}" "$@"
}

function clang-tidy-custom () {
    # (from https://matt.sh/howto-c)
    # This function is a policy driven code refactoring tool. The options above
    # enable two fixups:
    # 
    # 1. Readability-braces-around-statements — force all if/while/for
    #    statement bodies to be enclosed in braces.  It's an accident of history
    #    for C to allow "brace optional" single statements after loop constructs
    #    and conditionals. It is inexcusable to write modern code without braces
    #    enforced on every loop and every conditional. Trying to argue "but, the
    #    compiler accepts it!" has nothing to do with the readability,
    #    maintainability, understandability, or skimability of code. You aren't
    #    programming to please your compiler, you are programming to please future
    #    people who have to maintain your current brain state years after
    #    everybody has forgotten why anything exists in the first place.
    # 2. misc-macro-parentheses — automatically add parens around all parameters
    #    used in macro bodies
    # 
    # NB clang-tidy is great when it works, but for some complex code bases it
    #    can get stuck. Also, clang-tidy doesn't format, so you need to run
    #    clang-format after you tidy to align new braces and reflow macros.
    # 
    # NB Only accepts one file at a time, but we can run it parallel against
    #    disjoint collections at once e.g. 
    #
    #     find . \( -name \*.c -or -name \*.cpp -or -name \*.cc \) |xargs -n1 -P4 cleanup-tidy
    #
    clang-tidy \
    -fix \
    -fix-errors \
    -header-filter=.* \
    --checks=readability-braces-around-statements,misc-macro-parentheses \
    $1 \
    -- -I.
}

#If you have many files, you can recursively process an entire source tree in parallel:
#
##!/usr/bin/env bash
#
## note: clang-tidy only accepts one file at a time, but we can run it
##       parallel against disjoint collections at once.
#find . \( -name \*.c -or -name \*.cpp -or -name \*.cc \) |xargs -n1 -P4 clang-tidy-custom
#
## clang-format accepts multiple files during one run, but let's limit it to 12
## here so we (hopefully) avoid excessive memory usage.
#find . \( -name \*.c -or -name \*.cpp -or -name \*.cc -or -name \*.h \) |xargs -n12 -P4 clang-format-custom -i


# Reduce noise re " dbind-WARNING **: 00:08:52.242: Couldn't register with accessibility bus: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken."
export NO_AT_BRIDGE=1

function is_prog_on_path () {
    if [[ $# -ne 1 ]]; then
        echo "Bash function usage: is_prog_on_path <some_program_name> # to determine if some_program_name is on path" 1>&2
        exit 1
    fi
    hash $1 &> /dev/null
    return $?
}

###############
# TERMINAL TYPE
###############
# Fix 'Unknown terminal type' err when ssh from rxvt terminal
export TERM='xterm-256color'

#######
# PATHS
#######
# Add user-specific bin and lib dirs to path
[[ -d $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -d $HOME/lib ]] && export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH
[[ -d $HOME/Dropbox/bin  ]] && export PATH=$HOME/Dropbox/bin:$PATH

########
# EDITOR
########
if is_prog_on_path nvim; then
    export EDITOR=nvim
    alias vi=nvim
elif is_prog_on_path vim; then
    export EDITOR=vim
    alias vi=vim
    alias vmi=vim
else
    export EDITOR=vi
fi

###########
# GRAPHICAL
###########
if [[ -n ${DISPLAY+x} ]]; then
    if [[ -f /usr/bin/setxkbmap ]]; then
        # Set the compose key to right alt
        setxkbmap -option compose:ralt
        # ???
        setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll gb
    fi
    # Disable 'tap to click' on touchpad
    if [[ -f /usr/bin/synclient ]] && $(xinput list | grep -q "Synaptics"); then
        /usr/bin/synclient MaxTapTime=0
    fi
fi

########
# PYTHON
########
# Env vars for virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev

# Reduce console noise when generating PySide figs using matplotlib
export QT_ACCESSIBILITY=0 

# Make easier to add/remove conda bin directory from path
function condaenable {
    CONDAPATH="${HOME}/miniconda3/bin"
    if [[ -d ${CONDAPATH} && ! (${PATH} == *${CONDAPATH}*) ]]; then 
        PATH="$CONDAPATH:$PATH"
    fi
}
function condadisable {
    CONDAPATH="${HOME}/miniconda3/bin"
    if [[ -d ${CONDAPATH} && ${PATH} == *${CONDAPATH}* ]]; then 
        #source "${CONDAPATH}/deactivate"
        PATH=$(python -c 'from __future__ import print_function; import os; print(":".join((p for p in os.environ["PATH"].split(":") if not "miniconda" in p)))')
    fi
}
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

########################
# OPEN USING DEFAULT APP
########################
# Quick way of opening file using default apps 
# (see ~/.config/mimetypes.list to customise
if is_prog_on_path gio; then
    alias ]='gio open'
elif is_prog_on_path xdg-open; then
    alias ]='xdg-open'
fi

#######
# CTAGS
#######

########
# PAGING
########
# Set preferred pager...
export PAGER='less'
# ... and enable colour output (output ANSI "color" escape sequences)
export LESS='-R'

######
# INFO
######
# Use vi/less bindings for info
alias info='info --vi-keys'

#####
# IPS
#####
# University of Sheffield IP for DNS fault-finding
export UOSWEB_IP=143.167.2.102

#####
# GIT
#####
# Add git status info to bash prompt using
GIT_PROMPT_DIR="${HOME}/.bash-git-prompt/"
if [[ ! -d ${GIT_PROMPT_DIR} ]]; then
    git clone https://github.com/magicmonty/bash-git-prompt.git ${GIT_PROMPT_DIR}
fi 
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
GIT_PROMPT_START=$(hostname)    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence
source "${GIT_PROMPT_DIR}/gitprompt.sh"

# Use 'hub' (https://github.com/github/hub) for interacting with GitHub from command-line
is_prog_on_path hub && eval $(hub alias -s)

#########
# C / C++
#########
# Add CCache dir to path
export PATH=/usr/lib/ccache:${PATH}

# Default ctags options for C code
alias ctags='ctags --c-kinds=cdfgmnstu'

######
# RUBY
######
# Add RVM (for managing ruby versions) to path
[[ -d $HOME/.rvm/bin ]] && export PATH=$PATH:$HOME/.rvm/bin

# Aliases for writing to / reading from clipboard
if is_prog_on_path xclip; then 
    alias getclip='xclip -selection clipboard -in'
    alias setclip='xclip -selection clipboard -out'
fi

# Use user-installed cabal in preference to system cabal
CABALDIR="$HOME/.cabal/bin"
[[ -d $CABALDIR ]] &&  export PATH=$CABALDIR:$PATH

###########
# PASSWORDS
###########
alias mypwgen='pwgen -BcnyC 12 10'

##########
# TODO.TXT
##########
alias t="$EDITOR $HOME/Dropbox/todotxt/{todo.txt,waiting.txt,parked.txt,sdm.txt,done.txt}"
# completion for todo.sh (todo.txt cli)
complete -F _todo t  

# Abbreviate long paths in prompt
PROMPT_DIRTRIM=3

#######
# MUSIC
#######
# Alias for best mpd client
alias m=ncmpcpp

# Calculate the bitrate of MP3 files
alias mp3bitrate='mp3info -r a -p "%f %r\n"'

#########
# BROWSER
#########
export WWW_HOME='https://duckduckgo.com'

#########
# ANSIBLE
#########
# Disable Ansible's use of cowsay
export ANSIBLE_NOCOWS=1

#########
# Tcl
#########
if is_prog_on_path rlwrap && is_prog_on_path tclsh; then
    alias tclsh='rlwrap -c tclsh'
fi

######
# GREP
######
# Enable coloured output
alias grep='grep --color=auto'

######
# DIFF
######
# Enable coloured output
alias diff='diff --color=auto'

#############
# KRITA HiDPI
export KRITA_HIDPI=ON
#############

##############################
# Allocate and use x MB of RAM
##############################
# Inspired by http://unix.stackexchange.com/a/254976
function memalloc () {
    if [[ $# -ne 1 ]]; then
        echo "usage: memalloc X, where X is the number of MB to allocate" >2
        return -1
    fi
    n_MB=$1
    yes | tr \\n x | head -c $(($n_MB * 1024 * 1024)) | grep n
}

####################
# Firefox HiDPI mode
####################
alias firefox-hidpi='GDK_SCALE=2 GDK_DPI_SCALE=1 firefox'

###############
# Is port open?
###############
function porty () {
    if [[ $# -ne 2 ]]; then
        echo "Check if a port is open using: porty hostname port" >2
        return -1
    fi
    _host=$1 
    _port=$2 
    timeout 1 bash -c "cat < /dev/null > /dev/tcp/${_host}/${_port}" 2>/dev/null && echo "port ${_port} is open" || echo "port ${_port} is closed"
}

#########################
# Reverse DNS using drill
#########################
function drill_rdns () {
    if [[ $# -ne 1 ]]; then
        echo "Reverse DNS lookup using drill.  Usage: drill_rns some_ip_address" >2
        return -1
    fi
    _ipaddr=$1
    drill -x $_ipaddr | grep PTR | tac | head -n 1 | cut -d '' -f5
}

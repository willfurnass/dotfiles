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
alias emacs='emacs -nw'


######
# Grep
######
# Enable coloured output
alias grep='grep --color=auto'


######
# Diff
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
if [ -n "${XDG_RUNTIME_DIR}" ]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi


#####
# GPG 
#####
# Set Agent socket location
export GPG_AGENT_INFO=$HOME/.gnupg/S.gpg-agent


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
if [[ -n $MODULESHOME ]] && $(module --version 2>&1 | grep -qEiv '\Wlua\W'); then
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
if [[ -n ${DISPLAY+x} ]]; then
    if is_prog_on_path xclip; then 
        alias getclip='xclip -selection clipboard -in'
        alias setclip='xclip -selection clipboard -out'
    fi
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
if [[ ! -d ${GIT_PROMPT_DIR} ]]; then
    git clone https://github.com/magicmonty/bash-git-prompt.git ${GIT_PROMPT_DIR}
fi 
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
GIT_PROMPT_START=$(hostname)    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence
source "${GIT_PROMPT_DIR}/gitprompt.sh"
GIT_SUBREPO_DIR="${HOME}/.git_subrepo_dir/"
if [[ ! -d ${GIT_SUBREPO_DIR} ]]; then
    git clone https://github.com/ingydotnet/git-subrepo  ${GIT_SUBREPO_DIR}
fi 
source "${GIT_SUBREPO_DIR}/.rc"

# Use 'hub' (https://github.com/github/hub) for interacting with GitHub from command-line
is_prog_on_path hub && eval $(hub alias -s)


########
# Python
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


#########
# Haskell
#########
# Use user-installed cabal in preference to system cabal
CABALDIR="$HOME/.cabal/bin"
[[ -d $CABALDIR ]] &&  export PATH=$CABALDIR:$PATH


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
# Browser
#########
export WWW_HOME='https://duckduckgo.com'


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


######
# Mutt
######
if is_prog_on_path neomutt; then
    mutt_prog=neomutt
else
    mutt_prog=mutt
fi
for acc in persgm workgm; do 
    alias ${acc}="${mutt_prog} -F ${HOME}/.mutt/muttrc.${acc}"
done
unset mutt_prog


#################
# Handy functions
#################

# Find non-ASCII chars in file
function find-non-ascii() {
    if [[ $# -ne 1 ]]; then
        echo "Bash function usage: find-non-ascii <some-file>  # find non-ascii chars in a file" 1>&2
        return -1
    fi
    local -r _fname=$1
    grep --color='auto' -P -n "[\x80-\xFF]" "${_fname}"
}

# Get env var value for particular PID
function env-var-for-pid() {
    if [[ $# -ne 2 ]]; then
        echo "Get value of env var defined for process when process started; usage: env-var-for-pid <process_id> <env_var_name>" 1>&2
        return -1
    fi
    local -r _pid=$1
    local -r _var=$2
    xargs --null --max-args=1 echo < /proc/${_pid}/environ | awk -F= "/^${_var}=/ {print \$2}"
}

# Reverse DNS using drill
function drill-rdns () {
    if [[ $# -ne 1 ]]; then
        echo "Reverse DNS lookup using drill.  Usage: drill-rns some_ip_address" >2
        return -1
    fi
    local -r _ipaddr=$1
    drill -x $_ipaddr | grep PTR | tac | head -n 1 | cut -d '' -f5
}

# Is port open? (pure bash)
function is-port-open () {
    if [[ $# -ne 2 ]]; then
        echo "Check if a port is open using: is-port-open hostname port" >2
        return -1
    fi
    local -r _host=$1 
    local -r _port=$2 
    timeout 1 bash -c "cat < /dev/null > /dev/tcp/${_host}/${_port}" 2>/dev/null && echo "port ${_port} is open" || echo "port ${_port} is closed"
}

# Allocate and use x MB of RAM
# (inspired by http://unix.stackexchange.com/a/254976)
function memalloc () {
    if [[ $# -ne 1 ]]; then
        echo "usage: memalloc X, where X is the number of MB to allocate" >2
        return -1
    fi
    local -r n_MB=$1
    yes | tr \\n x | head -c $(($n_MB * 1024 * 1024)) | grep n
}

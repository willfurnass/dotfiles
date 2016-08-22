export EDITOR=vim

# Quick way of opening file using default Gnome app
alias ]='gnome-open'

# Set default GRASS GIS UI to the wx version
alias grass='grass -wx'

# Disable 'tap to click' on touchpad
if [ -f /usr/bin/synclient ] && $(xinput list | grep -q "Synaptics"); then
    /usr/bin/synclient MaxTapTime=0
fi

# Default ctags options for C code
alias ctags='ctags --c-kinds=cdfgmnstu'

# Set preferred pager...
export PAGER='less'
# ... and enable colour output (output ANSI "color" escape sequences)
export LESS='-R'

# Uncomment to enable anti-aliased fonts in Maple
# export _JAVA_OPTIONS="$_JAVA_OPTIONS -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

# Env vars for virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev

# Correct typo when try to start vim using vmi
alias vmi='vim'

# Set the compose key to right alt
if [ -f /usr/bin/setxkbmap ]; then
    setxkbmap -option compose:ralt
fi

# University of Sheffield IP for DNS fault-finding
export UOSWEB_IP=143.167.2.102

# Reduce console noise when generating PySide figs using matplotlib
export QT_ACCESSIBILITY=0 

# Python bindings to Qt4: ~se PySide rather than PyQt4
export QT_API="pyside"

# Add git status info to bash prompt using
GIT_PROMPT_DIR="${HOME}/dev/bash-git-prompt/"
if [ ! -d "${GIT_PROMPT_DIR}" ] && $(which git > /dev/null); then
    git clone https://github.com/magicmonty/bash-git-prompt.git "${GIT_PROMPT_DIR}" 
fi
if [ -d "${GIT_PROMPT_DIR}" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
    GIT_PROMPT_START=$(hostname)    # uncomment for custom prompt start sequence
    # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence
    source "${GIT_PROMPT_DIR}"/gitprompt.sh
fi

if [ -f /usr/bin/setxkbmap ]; then
    setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll gb
fi

# Add RVM (for managing ruby versions) to path
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Add CCache dir to path
export PATH=/usr/lib/ccache:${PATH}

# Add user-specific bin and lib dirs to path
export PATH=$HOME/Software/bin:$PATH
export LD_LIBRARY_PATH=$HOME/Software/lib:$LD_LIBRARY_PATH
export PATH=$HOME/Dropbox/bin:$PATH

# Dir for storing Python wheels (packages)
if [[ -f /etc/lsb-release ]]; then
    source /etc/lsb-release
    export WHEELHOUSE="/home/will/dev/wheelhouse/$DISTRIB_ID$DISTRIB_RELEASE"
fi

# Aliases for writing to / reading from clipboard
if $(hash xclip 2>/dev/null); then 
    alias setclip='xclip -selection c'
    alias getclip='xclip -selection clipboard -o'
fi

# Use user-installed cabal in preference to system cabal
CABALDIR="${HOME}/.cabal/bin"
if [[ -d ${CABALDIR} ]]; then
    export PATH=${CABALDIR}:${PATH}
fi

# Make easier to add/remove conda bin directory from path
function condaenable {
    CONDAPATH="${HOME}/miniconda3/bin"
    if [[ -d ${CONDAPATH} && ! (${PATH} == *${CONDAPATH}*) ]]; then 
        export QT_API_OLD="${QT_API}"
        #source "${CONDAPATH}/activate" $1
        PATH="$CONDAPATH:$PATH"
        export QT_API='pyqt'
    fi
}
function condadisable {
    CONDAPATH="${HOME}/miniconda3/bin"
    if [[ -d ${CONDAPATH} && ${PATH} == *${CONDAPATH}* ]]; then 
        #source "${CONDAPATH}/deactivate"
        PATH=$(python -c 'from __future__ import print_function; import os; print(":".join((p for p in os.environ["PATH"].split(":") if not "miniconda" in p)))')
        export QT_API="${QT_API_OLD}"
    fi
}

# PySpark environment vars
export PYSPARK_PYTHON=python3 
export PYSPARK_DRIVER_PYTHON=ipython 
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"

alias mypwgen='pwgen -BcnyC 12 10'

alias nv=nvim

# Alias for todo.txt CLI
alias t='nvim ${HOME}/Dropbox/todotxt/{todo.txt,waiting.txt,parked.txt,sdm.txt,done.txt} || vim ${HOME}/Dropbox/todotxt/{todo.txt,waiting.txt,parked.txt,sdm.txt,done.txt}'
# completion for todo.sh (todo.txt cli)
complete -F _todo t  

# Abbreviate long paths in prompt
PROMPT_DIRTRIM=3

alias m=ncmpcpp

# Disable Ansible's use of cowsay
export ANSIBLE_NOCOWS=1

export WWW_HOME='https://duckduckgo.com'

alias mp3bitrate='mp3info -r a -p "%f %r\n"'

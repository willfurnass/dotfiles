# Quick way of opening file using default Gnome app
alias ]='gnome-open'

# Set default GRASS GIS UI to the wx version
alias grass='grass -wx'

# Disable 'tap to click' on touchpad
/usr/bin/synclient MaxTapTime=0

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
setxkbmap -option compose:ralt

# University of Sheffield IP for DNS fault-finding
export UOSWEB_IP=143.167.2.101

# Reduce console noise when generating PySide figs using matplotlib
export QT_ACCESSIBILITY=0 

# Python bindings to Qt4: ~se PySide rather than PyQt4
export QT_API="pyside"

# Add git status info to bash prompt using
# github.com/magicmonty/bash-git-prompt.git
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
GIT_PROMPT_START=$(hostname)    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

source ~/dev/bash-git-prompt/gitprompt.sh

setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll gb

# Add RVM (for managing ruby versions) to path
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Add CCache dir to path
export PATH=/usr/lib/ccache:${PATH}

# Add user-specific bin and lib dirs to path
export PATH=$HOME/Software/bin:$PATH
export LD_LIBRARY_PATH=$HOME/Software/lib:$LD_LIBRARY_PATH
export PATH=$PATH:$HOME/Dropbox/bin

# Dir for storing Python wheels (packages)
if [ -f /etc/lsb-release ]; then
    source /etc/lsb-release
    export WHEELHOUSE="/home/will/dev/wheelhouse/$DISTRIB_ID$DISTRIB_RELEASE"
fi

# Aliases for writing to / reading from clipboard
if $(hash xclip 2>/dev/null); then 
    alias setclip='xclip -selection c'
    alias getclip='xclip -selection clipboard -o'
fi

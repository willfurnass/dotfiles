xrdb ~/.Xresources

# Needed for running qmon (Sun Grid Engine)
if [ -d /usr/share/fonts/X11/100dpi ]; then
    # Paths in Ubuntu
    FontPath /usr/share/fonts/X11/100dpi
    FontPath /usr/share/fonts/X11/75dpi
elif [ -d /usr/share/fonts/100dpi ]; then 
    # Paths in Arch
    FontPath /usr/share/fonts/100dpi
    FontPath /usr/share/fonts/75dpi
fi

# NB do not need to start gpg-agent explicitly any more
# as now automatically started by gpg
#eval $(gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info")

exec /usr/bin/i3 -V -d all >> ~/.i3.log

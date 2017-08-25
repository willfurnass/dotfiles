xrdb ~/.Xresources

# Needed for running qmon (Sun Grid Engine)
if [[ -d /usr/share/fonts/X11/100dpi ]]; then
    # Paths in Ubuntu
    FontPath /usr/share/fonts/X11/100dpi
    FontPath /usr/share/fonts/X11/75dpi
elif [[ -d /usr/share/fonts/100dpi ]]; then 
    # Paths in Arch
    FontPath /usr/share/fonts/100dpi
    FontPath /usr/share/fonts/75dpi
fi

[ -f ~/.fehbg ] && ~/.fehbg & 

#/sbin/lspci | grep -q GeForce && xrandr --setprovideroutputsource modesetting NVIDIA-0
#/sbin/lspci | grep -q GeForce && xrandr --auto

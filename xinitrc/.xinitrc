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
synclient TapButton1=1

# Set wallpaper
[ -f ~/.fehbg ] && ~/.fehbg & 

# Disable tap to click on trackpad
synclient TapButton1=1

#/sbin/lspci | grep -q GeForce && xrandr --setprovideroutputsource modesetting NVIDIA-0
#/sbin/lspci | grep -q GeForce && xrandr --auto

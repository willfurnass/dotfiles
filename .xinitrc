# Needed for running qmon (Sun Grid Engine)
FontPath /usr/share/fonts/X11/100dpi
FontPath /usr/share/fonts/X11/75dpi

/sbin/lspci | grep -q GeForce && xrandr --setprovideroutputsource modesetting NVIDIA-0
/sbin/lspci | grep -q GeForce && xrandr --auto

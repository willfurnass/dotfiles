[[ -z $(pgrep -xU $UID mpd) ]] && mpd ${HOME}/.config/mpd/mpd.conf &
[[ -z $(pgrep -xU $UID mpdscribble) ]] && mpdscribble --conf ${HOME}/.config/mpdscribble/mpdscribble.conf &
# Needed for running qmon (Sun Grid Engine)
FontPath /usr/share/fonts/X11/100dpi

[[ -z $(pgrep -xU $UID mpd) ]] && mpd ${HOME}/.config/mpd/mpd.conf &
[[ -z $(pgrep -xU $UID mpdscribble) ]] && mpdscribble --conf ${HOME}/.config/mpdscribble/mpdscribble.conf &

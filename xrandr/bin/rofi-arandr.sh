#!/bin/sh
# Interactively select xrandr profiles using arandr-generated scripts stored in ~/.screenlayout 

LAYOUTS_DIR="${HOME}/.screenlayout/"
[ -d "${LAYOUTS_DIR}" ] || exit 1
TMPFILE='/tmp/rofi-arandr'
truncate -s 0 "$TMPFILE" || touch "$TMPFILE"
ls -1 "${LAYOUTS_DIR}" >> $TMPFILE

LAYOUT=$(rofi -dmenu -fg "#f1f1f1" -bg "#333333" -hlfg "#ffffff" -hlbg "#336699" -o 85 -p "Monitor layout: " -i -input "$TMPFILE")
echo "$LAYOUT" > /tmp/layout_now.log
[ -f "${LAYOUTS_DIR}/${LAYOUT}" ] && /bin/sh "${LAYOUTS_DIR}/${LAYOUT}" && [ -f ~/.fehbg ] && ~/.fehbg


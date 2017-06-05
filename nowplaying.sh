#!/bin/sh
HAS_SIJI=$(grep -i "^[^#].*\$mod+return" ~/.config/i3/config | grep -o urxvt)
ICON=""
[ ! -z $HAS_SIJI ] && ICON=""
echo "$ICON $(playerctl metadata artist 2>/dev/null) - $(playerctl metadata title 2>/dev/null)"

#!/bin/sh

[ -z $DURATION ] && DURATION=3

# define geometry
barx=25
bary=47
barw=200
barh=30
[ -z $GEOMETRY ] && GEOMETRY="${barw}x${barh}+${barx}+${bary}"

[ -z $BG ] && BG='#bb00245e'
[ -z $FG ] && FG='#ffeceff1'

# font used
bar_font='-*-gohup-medium-*-*-*-11-*-*-*-*-*-iso10646-*'
icon_font='-wuncon-siji-medium-r-normal--11-100-*-*-*-*-iso10646-*'


[ ! -z $OVERLAY ] && NAME="panel_overlay"

baropt="-d -g ${GEOMETRY} -F ${FG} -B${BG} -f ${bar_font} -f ${icon_font}"

[ ! -z $NAME ] && baropt="$baropt -n $NAME"

if [ "$DURATION" == "unlimited" ]; then
  echo "$@" | lemonbar ${baropt} -p | sh
else
  (echo "%{c}$@"; sleep ${DURATION}) | lemonbar ${baropt} | sh
fi

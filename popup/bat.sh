#!/bin/sh
cd $(dirname $0)

left=1125
top=24

WIDTH=156 HEIGHT=53 ../batgraph

power=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk -F'[[:space:]][[:space:]]+' '/percentage/ { print $3 }')
state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk -F'[[:space:]][[:space:]]+' '/state/ { print $3 }')
timeremaining=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk -F'[[:space:]][[:space:]]+' '/(time to empty|time to full)/ { print $3 }')

if [ "$state" == "discharging" ]; then
  timetext="There's $timeremaining left."
elif [ "$state" == "fully-charged" ]; then
  timetext="Fully charged."
else
  timetext="$timeremaining until full."
fi

if [ -z $(pgrep -f "n30f.*batgraph\.png") ]; then
  n30f -x "$left" -y "$top" ~/scripts/popup/bg.png&
  sleep 0.1
  n30f -x $(bc <<< "$left + 11") -y $(bc <<< "$top + 33") /tmp/batgraph.png&
  DURATION="unlimited" BG="#00000000" FG="#FF2c3643" OVERLAY="true" GEOMETRY="168x10+$(bc <<< "$left + 2")+$(bc <<< "$top + 12")" ./popup.sh "%{c}Charge level is $power."&
  DURATION="unlimited" BG="#00000000" FG="#FF2c3643" OVERLAY="true" GEOMETRY="168x10+$(bc <<< "$left + 2")+$(bc <<< "$top + 105")" ./popup.sh "%{c} $timetext"&
  sleep 5
  pkill -f "n30f.*bg\.png"
  pkill -f "n30f.*batgraph\.png"
  killall lemonbar
else
  pkill -f "n30f.*bg\.png"
  pkill -f "n30f.*batgraph\.png"
fi

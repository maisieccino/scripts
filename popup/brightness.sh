#!/bin/sh

output=""

if [ "$1" == "up" ]; then
  xbacklight -inc 10
  output="${output}"
elif [ "$1" == "down" ]; then
  xbacklight -dec 10
  output="${output}"
fi

brightness=$(grep -oP ".*(?=\.)" <<< $(xbacklight -get))

output="$output $brightness $(/home/mbell/scripts/progress $brightness)"

if pgrep -f "lemonbar.*popup_brightness" > /dev/null; then
  echo $(pgrep -f "lemonbar.*popup_brightness")
  pkill -f "lemonbar.*popup_brightness"
  NAME="popup_brightness" DURATION=2 ~/scripts/popup/popup.sh "$output"
else
  NAME="popup_brightness" DURATION=2 ~/scripts/popup/popup.sh "$output"
fi

#!/bin/sh

output=""

if [ "$1" == "up" ]; then
  pamixer -i 5
  output=""
elif [ "$1" == "down" ]; then
  pamixer -d 5
  output=""
elif [ "$1" == "mute" ]; then
  pamixer -t
fi

volume=$(pamixer --get-volume)
if pamixer --get-mute; then
  output=" "
else
  if [ "$volume" -le "30" ]; then
    output="$output "
  else
    output="$output "
  fi
fi

output="$output $volume $(fg="2c3643" bg="606c7c" ~/scripts/progress $volume)"

if pgrep -f "lemonbar.*popup_volume" > /dev/null; then
  echo $(pgrep -f "lemonbar.*popup_volume")
  pkill -f "lemonbar.*popup_volume"
  NAME="popup_volume" DURATION=2 ~/scripts/popup/popup.sh "$output"
else
  NAME="popup_volume" DURATION=2 ~/scripts/popup/popup.sh "$output"
fi

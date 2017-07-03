#!/usr/bin/env bash

OFFSET_RE="\+([-0-9]+)\+([-0-9]+)"

# Get the window position
pos=($(xdotool getmouselocation | 
grep -oP '(?<=[xy]:)\d+'))
# Loop through each screen and compare the offset with the window
# coordinates.
while read name width height xoff yoff
do
  if [ "${pos[0]}" -ge "$xoff" \
    -a "${pos[1]}" -ge "$yoff" \
    -a "${pos[0]}" -lt "$(($xoff+$width))" \
    -a "${pos[1]}" -lt "$(($yoff+$height))" ]
  then
    monitor=$name   
  fi
done < <(xrandr | grep -w connected |
  sed -r "s/^([^ ]*).*\b([-0-9]+)x([-0-9]+)$OFFSET_RE.*$/\1 \2 \3 \4 \5/" |
  sort -nk4,5)

# If we found a monitor, echo it out, otherwise print an error.
if [ ! -z "$monitor" ]
then
  echo $monitor
  exit 0
else
  echo "Couldn't find any monitor for the current window." >&2
  exit 1
fi

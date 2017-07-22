#!/bin/bash

filename="$@"
thumbname="$(echo $filename | sed "s/\./-thumb\./")"

echo "$thumbname"
notify-send -a "scrot" -i "$HOME/Documents/scrots/auto/$thumbname" "Screenshot taken!" "Saved as $filename"

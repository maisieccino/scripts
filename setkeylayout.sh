#!/bin/sh

## SETKEYLAYOUT.SH
# Provides a menu to set keyboard layout via menu.

# get list of kb layouts and kb variants
LAYOUTS=$(awk '/! layout/{p=1;print;next} p&&/^!/{p=0};p' /usr/share/X11/xkb/rules/base.lst | tail -n +2)
VARIANTS=$(awk '/! variant/{p=1;print;next} p&&/^!/{p=0};p' /usr/share/X11/xkb/rules/base.lst | tail -n +2)
# remove leading whitespace
LAYOUTS=$(sed -r "s/^\s+//g" <<< "$LAYOUTS")
VARIANTS=$(sed -r "s/^\s+//g" <<< "$VARIANTS") 

# choose layout from list (nice format)
layout=$(echo "$LAYOUTS" | awk -F'[[:space:]][[:space:]]+' '{ print $2 }' | rofi -i -p "layout> " -dmenu)

# user cancelled? quit script.
[[ $? != 0 ]] && exit 0

# select keymap code from layouts list.
layout=$((grep "$layout" | cut -d' ' -f1) <<< "$LAYOUTS")

# filter variants to those applicable to selected keymap
VARIANTS=$(grep "$layout:" <<< "$VARIANTS")
VARIANTS="none
$VARIANTS"

# choose variant from list (nicely formatted)
variant=$((grep -oP '(?<=gb:[ ]).*' | rofi -i -p "variant> " -dmenu) <<< "$VARIANTS")

# user cancelled? quit script.
[[ $? != 0 ]] && exit 0

# select variant code
variant=$((grep "$variant" | cut -d' ' -f1) <<< "$VARIANTS")

# echo "$layout"
# echo "$variant"

# don't use a kb variant if "none" selected.
if [ "$variant" == "none" ]
then
  variant=""
fi

setxkbmap "$layout" "$variant"

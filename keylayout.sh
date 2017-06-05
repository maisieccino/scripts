#!/bin/sh

layout=$( setxkbmap -query | awk "/layout/ { print \$2 }")
variant=$( setxkbmap -query | awk "/variant/ { print \$2 }")

if [ "$1" == "-f" ]
then
  # shift parameters.
  shift

  # make sure format string defined if flag true.
  if [ ! -z "$@"]
  then
    fmtstr=$(sed -r "s/\%layout/$layout/; s/\%variant/$variant/" <<< "$@")
  else
    >&2 echo "No format string specified"
    exit 127
  fi
else
  # if variant, put it in brackets
  # aka revert to default
  if [ ! -z "$variant" ] 
  then
    variant="($variant)"
  fi
  fmtstr="$layout $variant"
fi

echo "$fmtstr"

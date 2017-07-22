#!/bin/bash

# required:
# libnotify
# https://github.com/vlevit/notify-send.sh
# python2
# imagemagick

arturl_url="/tmp/spotify_albumart"
arturl_img="/tmp/spotify_albumart.png"
arturl_resized="/tmp/spotify_albumart_resized.png"
arturl_notification="/tmp/spotify_notification.png"
background_img="$HOME/scripts/notification-bg.png"
notification_idfile="/tmp/spotify_notificationfile"
touch "$arturl_url"

while true; do
  until player_pids=$(pidof "spotify")
  do
    sleep 10
  done

  playerdata=$($HOME/scripts/playerctl-change.py spotify 2>/dev/null)
  # convert to array
  arr=()
  while read -r line; do
    arr+=("$line")
  done <<< "$playerdata"

  artist="${arr[0]}"
  track="${arr[1]}"
  arturl="${arr[2]}"

  if [ -z "$track" ]; then
    continue
  fi

  # get new art if changed.
  if [ "$(echo $arturl | diff - $arturl_url)" ]; then
    echo "$arturl" > "arturl_url"
    # https://www.reddit.com/r/archlinux/comments/5np6ne/need_some_help_with_a_little_bash_script/
    wget -4 -O "$arturl_img" "$arturl" 
    convert "$arturl_img" -quality 100 -resize 64x64 "$arturl_resized"
        composite -gravity west "$arturl_resized" "$background_img" "$arturl_notification"
    notify-send.sh -R "$notification_idfile" -c "presence" -a spotify -i "$arturl_notification" "Now Playing" "$artist\n$track"
  fi
done

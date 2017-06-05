#!/bin/sh
cd $(dirname $0)

left=25
top=48

destroypopup() {
  pkill -f "n30f.*bg-player\.png"
  pkill -f "n30f.*albumart\.png"
  pkill -f "lemonbar.*-g 215x12"
  pkill -f "^sh.*music\.sh"
}

drawpopup() {
  status=$(playerctl status 2>/dev/null)
  if [ -z "$status" ]; then
    exit 1
  fi

  artist=$(playerctl metadata xesam:artist)
  track=$(playerctl metadata xesam:title)
  album=$(playerctl metadata xesam:album)

  if [ "$status" == "Playing" ]; then
    playglyph=""
  else
    playglyph=""
  fi
  playbutton="%{A:~/scripts/popup/music.sh pause:}$playglyph%{A}"
  nextbutton="%{A:~/scripts/popup/music.sh next:}%{A}"
  prevbutton="%{A:~/scripts/popup/music.sh prev:}%{A}"
  controltext="$prevbutton    $playbutton    $nextbutton"

  volume=$(pamixer --get-volume)
  volumebar="Vol: $volume $(~/scripts/progress $volume)"

  WIDTH=71 HEIGHT=71 ../getalbumart

  n30f -x "$left" -y "$top" ~/scripts/popup/bg-player.png&
  sleep 0.1
  n30f -x $(bc <<< "$left + 2") -y $(bc <<< "$top + 2") /tmp/albumart.png&

  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="215x12+$(bc <<< "$left + 78")+$(bc <<< "$top + 5")" ./popup.sh "%{c}$artist"&
  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="215x12+$(bc <<< "$left + 78")+$(bc <<< "$top + 17")" ./popup.sh "%{c}$track"&
  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="215x12+$(bc <<< "$left + 78")+$(bc <<< "$top + 29")" ./popup.sh "%{c}$album"&

  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="215x12+$(bc <<< "$left + 78")+$(bc <<< "$top + 45")" ./popup.sh "%{c}$controltext"&
  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="215x12+$(bc <<< "$left + 78")+$(bc <<< "$top + 58")" ./popup.sh "%{c}$volumebar"&
  sleep 4.9
  destroypopup
}

if [ "$1" == "pause" ]; then
  playerctl play-pause
elif [ "$1" == "next" ]; then
  playerctl next
elif [ "$1" == "prev" ]; then
  playerctl previous
fi

sleep 0.1

if [ -z $(pgrep -f "n30f.*bg-player\.png") ]; then
  drawpopup
else
  destroypopup
  drawpopup
fi

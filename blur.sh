#!/bin/sh
scrot /tmp/lock.png

convert /tmp/lock.png -scale 10% -scale 1000% /tmp/lock.png

i3lock -i /tmp/lock.png
rm /tmp/lock.png

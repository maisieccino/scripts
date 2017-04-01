#!/bin/sh

while [ "true" ]
do
    echo "Now Playing:" > music.txt
    echo $(mpc current) >> music.txt
    sleep 1
done

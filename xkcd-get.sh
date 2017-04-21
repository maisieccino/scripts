#!/bin/sh

mkdir -p ~/.xkcd
cd ~/.xkcd/
rm ~/.xkcd/*
echo "Finding latest XKCD..."

wget -q -O- "https://xkcd.com" | grep -o '<div id="ctitle">[^<]*' | grep -o '[^>]*$' | xargs echo


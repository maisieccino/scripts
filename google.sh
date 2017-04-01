#!/bin/bash
function google
{
    Q="$@"
    GOOG_URL='https://www.google.de/search?tbs=li:1&q='
    AGENT="Mozilla/4.0"
    stream=$(
        curl -A "$AGENT" -skLm 10 "${GOOG_URL}${Q//\ /+}" \
        | grep -oP '\/url\?q=.+?&amp' \
        | sed 's|/url?q=||; s|&amp||')
    echo -e "${stream//\%/\x}"
}
google $@ | tail -n1 | xargs chromium

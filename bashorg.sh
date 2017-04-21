#!/bin/bash
curl -s http://bash.org/?random1|grep -oE "<p class=\"quote\">.*</p>.*</p>"|grep -oE "<p class=\"qt.*?</p>"|sed -e 's/<\/p>/\n/g' -e 's/<p class=\"qt\">//g' -e 's/<p class=\"qt\">//g'|perl -ne 'use HTML::Entities;print decode_entities($_),"\n"'|awk 'length($0)>0  {printf( $0 "\n%%\n" )}' > bash_quotes.txt
sleep 3
strfile bash_quotes.txt

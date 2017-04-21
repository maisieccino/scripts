#!/bin/sh

# how long should the popup remain?
duration=3

# define geometry
barx=10
bary=10
barw=120
barh=20

# colors
bar_bg='#ff333333'
bar_fg='#ffffffff' # white is default

# font used
bar_font='-*-gohufont-medium-*-*--11-*-*-*-*-*-iso10646-1'

# compute all this
baropt='-n POPUP -g ${barw}x${barh}+${barx}+${bary} -B${bar_bg} -f ${bar_font}'

# Create the popup and make it live for 3 seconds
(echo " $@"; sleep ${duration}) | lemonbar ${baropt}

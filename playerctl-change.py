#!/usr/bin/env python3

# source: https://github.com/orestisf1993/i3blocks/blob/master/blocks/playerctl-change.py
from gi.repository import Playerctl, GLib
import sys
import signal

PLAYER_NAME = sys.argv[1]
TIMEOUT = 2

def player_is_running(player_name):
    return Playerctl.Player(player_name=player_name).props.metadata is not None


def handler(signum, frame):
    raise TimeoutError


def on_metadata(player, e=None):
    e = player.props.metadata if e is None else e
    if player_is_running(PLAYER_NAME):
        print('{artist}\n{title}\n{icon}'.format(artist=e['xesam:artist'][0], title=e['xesam:title'], icon=e['mpris:artUrl']))
    sys.exit(0)


if not player_is_running(PLAYER_NAME):
    sys.exit()

#artist = player.props.metadata['xesam:artist']
#title = player.props.metadata['xesam:title']

player = Playerctl.Player(player_name=PLAYER_NAME)
player.on('metadata', on_metadata)

# wait for events
main = GLib.MainLoop()
#signal.signal(signal.SIGALRM, lambda n, f: main.quit())
#signal.alarm(1)
GLib.timeout_add_seconds(TIMEOUT, lambda: sys.exit(0))
main.run()

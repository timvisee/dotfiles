#!/bin/bash

if [ "$(playerctl status)" = "Stopped" ]; then
    echo "No music is playing"
elif [ "$(playerctl status)" = "Paused"  ]; then
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook spotify-play-pause 2 1>/dev/null 2>&1
    playerctl metadata --format "{{ title }} - {{ artist }}"
else # Can be configured to output differently when player is paused
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook spotify-play-pause 1 1>/dev/null 2>&1
    playerctl metadata --format "{{ title }} - {{ artist }}"
fi

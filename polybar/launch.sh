#!/usr/bin/env bash

# Terminate already running bar instances, wait until shut down
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start polybar on all screens
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload example &
done

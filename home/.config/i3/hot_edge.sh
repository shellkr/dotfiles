#!/bin/bash

echo "started $0"

xdotool behave_screen_edge --delay 500 left key Alt+1 & left_edge=$!
#xdotool behave_screen_edge --delay 500 left key Super+left & left_edge=$!
xdotool behave_screen_edge --delay 500 right key Alt+2 & right_edge=$!
#xdotool behave_screen_edge --delay 500 right key Super+right & right_edge=$!

sleep 10m

kill $right_edge $left_edge

sleep 2

$0


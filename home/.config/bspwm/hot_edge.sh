#!/bin/bash

echo "started $0"

while true
do
	xdotool behave_screen_edge --delay 500 bottom-left key Alt+1 & left_edge=$!
	xdotool behave_screen_edge --delay 500 bottom-right key Alt+2 & right_edge=$!
	sleep 5m
	kill $right_edge $left_edge
done


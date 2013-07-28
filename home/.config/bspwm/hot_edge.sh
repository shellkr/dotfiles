#!/bin/bash

echo "started $0"

while true
do
	xdotool behave_screen_edge --delay 500 left key Alt+1 & left_edge=$!
	xdotool behave_screen_edge --delay 500 right key Alt+2 & right_edge=$!
	sleep 10m
	kill $right_edge $left_edge
done


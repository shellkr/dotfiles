#!/bin/bash
# dwb: xmp
mpv $(quvi scan $DWB_URI|sed '/#/d') &
notify-send -u low "Mpv opening $DWB_URI" #optional notification

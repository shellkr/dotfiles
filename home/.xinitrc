#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi


#gpg-agent --server
compton --config ~/.config/i3/compton.conf -b &
numlockx &
/home/daniel/.config/i3/./wallpaper_ch &
/home/daniel/.config/i3/./hot_edge.sh &
exec i3 -V >> ~/.cache/i3log 2>&1 

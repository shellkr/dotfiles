#!/bin/sh

system_xinitrc() {
	if [ -d /etc/X11/xinit/xinitrc.d ] ; then
		for f in /etc/X11/xinit/xinitrc.d/* ; do
			[ -x "$f" ] && . "$f"
		done
		unset f
	fi
}

use_gpg_agent() {
	eval $(gpg-agent --daemon) & # --default-cache-ttl 4200) &
}

init_desktop() {
	[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
	setxkbmap -option terminate:ctrl_alt_bksp
	xsetroot -cursor_name left_ptr &
	compton --config ~/.config/i3/compton.conf -b &
	numlockx &
	/home/daniel/.config/bspwm/./wallpaper_ch &
	/home/daniel/.config/bspwm/./hot_edge.sh &
}

run_bspwm() {
	source /etc/environment

	[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
	mkfifo "$PANEL_FIFO"

	sxhkd -c ~/.config/bspwm/sxhkdrc &
	exec bspwm -s "$PANEL_FIFO" -p W
}

system_xinitrc
init_desktop
run_bspwm



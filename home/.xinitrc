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
    source ~/.profile
	setxkbmap -option terminate:ctrl_alt_bksp
	xsetroot -cursor_name left_ptr &
    xset -dpms &
    xset s off &
    xset s noblank &
	compton --config ~/.config/i3/compton.conf -b &
	numlockx &
	wallpaper_ch &
	hot_edge.sh &
}

run_bspwm() {
	sxhkd -c $XDG_CONFIG_HOME/bspwm/sxhkdrc &
    exec /usr/bin/bspwm
}

use_gpg_agent
system_xinitrc
init_desktop
run_bspwm



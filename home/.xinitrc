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
	compton --config ~/.config/scripts/compton.conf -b &
	numlockx &
	wallpaper_ch &
	hot_edge.sh &
	/usr/bin/vendor_perl/clipbored
	pacmd set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-headphones 
}

run_bspwm() {
	sxhkd -c $XDG_CONFIG_HOME/bspwm/sxhkdrc &
	exec /usr/bin/bspwm
}

run_awesome() {
	exec /usr/bin/awesome
}

run_snapwm() {
	exec /usr/bin/snapwm
}

run_herbstluftwm() {
	exec /usr/bin/herbstluftwm
}

#use_gpg_agent
system_xinitrc
init_desktop
run_bspwm


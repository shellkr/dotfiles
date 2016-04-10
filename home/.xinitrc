#!/bin/bash

system_xinitrc() {
	if [ -d /etc/X11/xinit/xinitrc.d ] ; then
		for f in /etc/X11/xinit/xinitrc.d/* ; do
			[ -x "$f" ] && . "$f"
		done
		unset f
	fi

}

use_gpg_agent() {
        eval $(gpg-agent --daemon --no-grab --enable-ssh-support --allow-loopback-pinentry) &
	/usr/lib/gnupg/gpg-preset-passphrase --preset 293D628ED5585FA528668536D3F243CC2E73B2EF &
}

init_desktop() {
	[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
	source ~/.profile
	setxkbmap -option terminate:ctrl_alt_bksp
#	start-pulseaudio-x11
	xsetroot -cursor_name left_ptr &
	xset -dpms &
    	xset s off &
    	xset s noblank &
	compton --config $XDG_CONFIG_HOME/scripts/compton.conf -b &
	numlockx &
	$XDG_CONFIG_HOME/scripts/wallpaper_ch &
	hot_edge.sh &
	/usr/bin/clipmenud &
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

run_i3() {
	exec /usr/bin/i3 -c $XDG_CONFIG_HOME/i3/config
}


#use_gpg_agent
system_xinitrc
init_desktop

session=${1:-bspwm}

case $session in
  bspwm   ) run_bspwm;;
  awesome ) run_awesome;;
  snapwm  ) run_snapwm;;
  herbst  ) run_herbstluftwm;;
  i3wm    ) run_i3;;
  * ) exec $1;;
esac


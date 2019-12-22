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
       # eval $(gpg-agent --daemon --no-grab --enable-ssh-support --allow-loopback-pinentry) &
       # eval $(gpg-agent --homedir $HOME/.gnupg --use-standard-socket --daemon --no-grab --allow-preset-passphrase) &


	# Start the gpg-agent if not already running
	#if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  	#	gpg-connect-agent /bye >/dev/null 2>&1
	#fi

	/usr/lib/gnupg/gpg-preset-passphrase --preset $(head -1 ~/gpgpass) &

	#unset SSH_AGENT_PID
        #if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
        #	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        #fi
}

init_desktop() {
	[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
	source ~/.profile
	setxkbmap -option terminate:ctrl_alt_bksp
	setxkbmap -option ctrl:nocaps &
	xsetroot -cursor_name left_ptr &
	xset -dpms &
    	xset s off &
    	xset s noblank &
#	autocutsel -fork &
#	autocutsel -selection PRIMARY -fork &
	compton --config $XDG_CONFIG_HOME/scripts/compton.conf -b &
	numlockx &
	$XDG_CONFIG_HOME/scripts/wallpaper_ch &
	hot_edge.sh &
#	run_keybase &
#	ipfs daemon &
#	clipmenud &
#	/usr/bin/xcmenu &
#	offlineimap -c ~/.mutt/offlineimaprc -l ~/.offlineimap.log 2>&1 /dev/null &
#        [ -e $HOME/.cache/rtorrent/session/rtorrent.lock ] && rm $HOME/.cache/rtorrent/session/rtorrent.lock;
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


[[ $DISPLAY = ":0" ]] && {
#	use_gpg_agent
	system_xinitrc
	init_desktop
}

# Run one of the below wm's else bspwm if no argument has been given
session=${1:-bspwm}

case $session in
  bspwm   ) run_bspwm;;
  awesome ) run_awesome;;
  snapwm  ) run_snapwm;;
  herbst  ) run_herbstluftwm;;
  i3wm    ) run_i3;;
  * ) exec $1;;
esac

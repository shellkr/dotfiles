PATH="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/usr/games:$HOME/.config/bspwm:$HOME/go/bin:$PATH"

## Android

if [ -d "/opt/android-sdk/platform-tools" ] ; then
  PATH="/opt/android-sdk/platform-tools:$PATH"
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

## Bspwm
export BSPWM_SOCKET="/tmp/bspwm-socket"
export BSPWM_TREE=/tmp/bspwm.tree
export BSPWM_HISTORY=/tmp/bspwm.history
export BSPWM_STACK=/tmp/bspwm.stack
export PANEL_FIFO=/tmp/panel-fifo
export PANEL_HEIGHT=16

## Rtv
export RTV_EDITOR=nano

## Browser
export BROWSER=w3m

## GnuPG
export GPG_TTY=$(tty)
export GPG_AGENT_INFO=/run/user/1000/gnupg/S.gpg-agent

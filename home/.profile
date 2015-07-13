PATH="/usr/games:$HOME/.config/bspwm:$PATH"

# Invoke GnuPG-Agent the first time we login.
# Does `~/.gpg-agent-info' exist and points to gpg-agent process accepting signals?
#if test -f $HOME/.gpg-agent-info && \
#    kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
#    GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info | cut -c 16-`
#else
#    # No, gpg-agent not available; start gpg-agent
#    eval `gpg-agent --daemon --no-grab --write-env-file $HOME/.gpg-agent-info`
#fi
#export GPG_TTY=`tty`
#export GPG_AGENT_INFO
#export GNUPGHOME=$HOME

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

## Bspwm
export BSPWM_SOCKET="/tmp/bspwm-socket"
export BSPWM_TREE=/tmp/bspwm.tree
export BSPWM_HISTORY=/tmp/bspwm.history
export BSPWM_STACK=/tmp/bspwm.stack
export PANEL_FIFO=/tmp/panel-fifo
export PANEL_HEIGHT=14

## Rtv
export RTV_EDITOR=nano

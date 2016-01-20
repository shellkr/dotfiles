## Set up the prompt
autoload -Uz compinit promptinit
autoload -Uz colors && colors
autoload -U bashcompinit
compinit
bashcompinit
promptinit
#prompt adam1
#RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}][%{$fg_no_bold[yellow]%}%T%{$reset_color%}]"

setopt histignorealldups sharehistory
setopt inc_append_history
setopt extendedglob

## spelling correction for commands
setopt correct

## spelling correction for arguments
#setopt correctall

## Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

## Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

## Rebind the delete key.
bindkey '\e[3~' delete-char

## Bind ctrl-left / ctrl-right
#bindkey "\e[1;5D" backward-word
#bindkey "\e[1;5C" forward-word
#bindkey '^[[5D' emacs-backward-word
#bindkey '^[[5C' emacs-forward-word
#bindkey ';5D' emacs-backward-word
#bindkey ';5C' emacs-forward-word
#bindkey "\e\e[D" backward-word
#bindkey "\e\e[C" forward-word
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word

## Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

export EDITOR="nano"
export GREP_COLORS='ms=01;33'

source  .config/powerlevel9k/powerlevel9k.zsh-theme
. /usr/share/zsh/site-contrib/powerline.zsh

for sd_cmd in systemctl systemd-analyze systemd-run; do
    alias $sd_cmd='DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/dbus/user_bus_socket" '$sd_cmd
done

if [ -f "${HOME}/.gpg-agent-info" ]; then
	. "${HOME}/.gpg-agent-info"
	export GPG_AGENT_INFO
#	export SSH_AUTH_SOCK
fi

## Transparent Xterm
[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null

## My Aliases
alias ls="ls -FshX --color=auto --group-directories-first"
alias less="less -R"
alias rm="rm -rf"
alias grep="grep --color=auto"
alias printmaint="cngpij -P Canon-MG5200-series_2C-9E-FC-09-C3-AB"
alias printstat="cngpijmonmg5200 Canon-MG5200-series_2C-9E-FC-09-C3-AB"
alias cpu="ps -eo pcpu,args --no-headers | sort -k 1 -r -n | head"
alias mem="free -m | awk '/Mem/{print \"Total used: \"\$3\"\nTotal left: \"\$7}' && echo && ps -eu 1000 k rss -o rss,args | \sort -r -n | awk '{print \$1/1024\"\tMB - \"\$2,\$3,\$4,\$5,\$6,\$7,\$8}' | colout '([0-9].*)(\tMB)(.*)' blue,black,yellow | head"
alias memp="ps -eo pmem,args | sort -k 1 -r -n | ccze -m ansi | head"
alias dmesg="dmesg -deL"
alias diff='colordiff -yZEwBd'
alias psc="ps xawf -eo pid,user,cgroup,args"
#alias fullupn='yaourt -Syua --devel --noconfirm'
#alias fullup='yaourt -Syua --devel'
alias fullupn='pacaur -Syu --devel --needed --noedit'
#alias yaourt="YAOURT_COLORS='other=1;30:pkg=0;33' yaourt"
age () { sudo dumpe2fs $(mount | grep 'on \/ ' | awk '{print $1}') | grep 'Filesystem created:' }
alias used='cut -f1 -d" " ~/.zsh_history | sort | uniq -c | sort -nr | head -n 30'
alias g+='echo -en "\xe2\x80\x8b" | xsel -i'
alias mpv="mpv $* 2>&1 > /dev/null"
#alias ffsc="ffmpeg -f x11grab -s 1920x1080 -i $DISPLAY -r 30 -f alsa -i default -preset ultrafast -c:v ffvhuff -c:a flac $HOME/Videos/Screencasts/screencast_$(date +'%y%m%d-%H%M').mkv"
#alias ffyt="ffmpeg -i $HOME/Videos/Screencasts/$1 -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a copy $HOME/Videos/Screencasts/yt_$1"

#time in Stockholm
klocka () {
	curl -s http://www.timeanddate.com/worldclock/sweden/stockholm | awk -F'(<*>|</)' '/id=ct/{print $21}'
}

# Make screencast or convert to yt
ffsc () {
echo $2
	case $1 in
		sc) ffmpeg -f x11grab -s 1920x1080 -i $DISPLAY -r 30 -f alsa -i default -preset ultrafast \
	    	    -c:v ffvhuff -c:a flac $HOME/Videos/Screencasts/screencast_$(date +'%y%m%d-%H%M').mkv
		;;
		yt) ffmpeg -i $2 -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a copy ${2/scr/yt_scr}
		;;
	esac
}

google () {
	$(firefox --new-tab "https://encrypted.google.com/search?hl=en&q=$1")
}

## stolen from http://dotshare.it/dots/461/
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

## stolen from https://gist.github.com/cirrusUK/35a7642f81097f4e5158
cmdfu() { curl "http://www.commandlinefu.com/commands/matching/$(echo "$@" \
| sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext" ;}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}


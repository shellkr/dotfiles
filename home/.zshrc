#source $HOME/.config/powerlevel9k/powerlevel9k.zsh-theme

POWERLEVEL9K_INSTALLATION_PATH=~/.zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme
#source $POWERLEVEL9K_INSTALLATION_PATH

#POWERLEVEL9K_MODE='awesome-fontconfig'
#POWERLEVEL9K_MODE='awesome-patched'
#POWERLEVEL9K_MODE='compatible'
#POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status nvm node_version)

#POWERLEVEL9K_OS_ICON_BACKGROUND="white"
#POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
#POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
#POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

## Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

export TERM="rxvt-256color"
export EDITOR="nano"
export GREP_COLORS='ms=01;33'

source <(madonctl completion zsh)

## Transparent Xterm
[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null

## My Aliases
alias ls="ls -FshX --color=auto --group-directories-first"
alias less="less -R"
alias rm="rm -rf"
alias grep="grep --color=auto"
alias cpu="ps -eo pcpu,args --no-headers | sort -k 1 -r -n | head"
alias dmesg="dmesg -deL"
alias diff='colordiff -yZEwBd'
alias psc="ps xawf -eo pid,user,cgroup,args"
alias fullupn='LOGDEST="/var/cache/" pacaur -Syu --devel --needed --noedit --noconfirm'
age () { sudo dumpe2fs $(mount | grep 'on \/ ' | awk '{print $1}') | grep 'Filesystem created:' }
used () { cat -n <(history 0 | awk '{ print $2}' | sort | uniq -c | sort -nr | head -n30) }
alias g+='echo -en "\xe2\x80\x8b" | xsel -i'
alias firefox='firejail --profile=/etc/firejail/firefox.profile --dns=8.8.8.8 --dns=8.8.4.4 --net=enp0s25 firefox'
alias sudo='sudo '
alias chkspace='sudo du -hsx * | sort -rh | head'
alias mutt="abduco -A -e '^q' mutt /usr/bin/mutt"
alias mpv='mpv -wid=$(bspc query -N -n) $1'
alias mplay='DISPLAY=:0 xdotool key --window $(ps -aux | sed -n '/mp3/p' | grep -Eo "[0]x0.......") space'
alias mprev='DISPLAY=:0 xdotool key --window $(ps -aux | sed -n '/mp3/p' | grep -Eo "[0]x0.......") "94"'
alias mnext='DISPLAY=:0 xdotool key --window $(ps -aux | sed -n '/mp3/p' | grep -Eo "[0]x0.......") shift+"94"'
alias tl='trans -b'

export GPG_TTY=$(tty)

## Start the gpg-agent if not already running
#if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
#  gpg-connect-agent /bye >/dev/null 2>&1
#	gpg-agent --homedir $HOME/.gnupg --no-grab --allow-preset-passphrase --daemon
#fi

# Refresh gpg-agent tty in case user switches into an X session
#gpg-connect-agent updatestartuptty /bye >/dev/null

## Set SSH to use gpg-agent
#unset SSH_AGENT_PID
#if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#   export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#fi

transfer () {
	curl --upload-file $1 https://transfer.sh/${1##*/}
}

#fetch img url and show with feh
fimg () {
        curl -s "$1" | feh - > /dev/null 2>&1
}

# mastodon
mad () {
	case $1 in
		not) madonctl accounts notifications --list --all | colout '(^.*Status ID.*|^.*From.*)|(^.*Notification.*)|(Timestamp.*|^.*URL.*|Attachment.*|@.*)|(Contents.*|^[a-zA-Z1-9#"\+].*)|(^.*Account.*)|(^.*Type.*|^.*In-Reply.*)' 237,4,16,189,4,88 ;;
		noc) madonctl accounts notifications --clear ;;
		st) madonctl stream | colout '(^.*Status ID.*|^.*Notification.*)|(Timestamp.*|^.*URL.*|Attachment.*|^Event:.*)|(Contents.*|^[a-z].*|^[A-Z].*|^[1-9].*|^#.*|^".*|^\+.*|^\(.*|\).*)|(^.*Account.*|From.*)|(Reblogged.*)|(^.*Attachment.*)|(^.*Type.*)' 160,16,189,4,59,237,88 underline,bold,bold,normal ;;
		stp) madonctl stream public | colout '(^.*Status ID.*|^.*Notification.*)|(Timestamp.*|^.*URL.*|Attachment.*|^Event:.*)|(Contents.*|^[a-z].*|^[A-Z].*|^[1-9].*|^#.*|^".*|^\+.*|^\(.*|\).*)|(^.*Account.*|From.*)|(Reblogged.*)|(^.*Attachment.*)|(^.*Type.*)' 160,16,189,4,59,237,88 underline,bold,bold,normal ;;
		stl) madonctl stream local | colout '(^.*Status ID.*|^.*Notification.*)|(Timestamp.*|^.*URL.*|Attachment.*|^Event:.*)|(Contents.*|^[a-z].*|^[A-Z].*|^[1-9].*|^#.*|^".*|^\+.*|^\(.*|\).*)|(^.*Account.*|From.*)|(Reblogged.*)|(^.*Attachment.*)|(^.*Type.*)' 160,16,189,4,59,237,88 underline,bold,bold,normal ;;
		addr) madonctl accounts follow -r $2
	esac
}


#time in Stockholm
klocka () {
        curl -s https://www.timeanddate.com/worldclock/sweden/stockholm | awk -F'(<*>|</)' '/id=ct/{print $21}'
}

#Weather forcast via nixCraft
wttr () {
	curl http://wttr.in/$1
}

who_where () {
	wget -q -O - "http://ip-api.com/csv/$1?fields=262143" | \
	awk -F',' '{print "City: "$6", "$5"\nCountry: "$2"\nIP-number: "$17" / "$11"\nMobile/Proxy: "$15" / "$16"\nPosition: "$8", "$9}' | \
	sed 's/"//g'
}

# Make screencast or convert to yt
ffsc () {

vid_name="$HOME/Videos/Screencasts/screencast_$(date +'%y%m%d-%H%M%S')"

        case $1 in
                sc) ffmpeg -f x11grab -s 1920x1080 -i $DISPLAY -r 30 -f alsa -i default -preset ultrafast \
                    -c:v ffvhuff -c:a flac ${vid_name}.mkv
                    printf "${vid_name}.mkv" | xsel -i
                    echo
                    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                    echo "Output file name: ${vid_name}.mkv"
                    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                    echo

		    [ -e /tmp/ffsc.tmp ] && { rm /tmp/ffsc.tmp }
		    printf "${vid_name}.mkv" > /tmp/ffsc.tmp
                ;;
                yt) ffmpeg -i $2 -c:v libx264 -crf 18 -preset slow -pix_fmt rgb24 -c:a copy ${2/scr/yt_scr}
		    yt_name=$(cat /tmp/ffsc.tmp)
		    printf "${yt_name/scr/yt_scr}" | xsel -i
                    echo
                    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                    echo "Output file name: ${yt_name/scr/yt_scr}"
                    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                    echo
                ;;
        esac
}

# Python as a calculator
pc() { python -c "print($*)"; } 

#Search Google
google () {
        $(firefox --new-tab "https://encrypted.google.com/search?hl=en&q=$1")
}

pb () {
  curl -sF "c=@${1:--}" -w "%{redirect_url}" 'https://ptpb.pw/?r=1' -o /dev/stderr | xsel -l /dev/null -p
#  curl -F "c=@${1:--}" https://ptpb.pw/
}

pbdel () {
  curl -X DELETE https://ptpb.pw/${1}
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


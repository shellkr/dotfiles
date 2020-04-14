source ~/.zsh_plugins.sh

#POWERLEVEL10K_INSTALLATION_PATH=~/.zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_MODE='nerdfont-complete'

DEFAULT_USER="v1rgul"
POWERLEVEL9K_USER_ICON="\uf300" # 
POWERLEVEL9K_OS_ICON="\uf300" # 

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator time)


POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"


autoload -Uz compinit
[[ -n ${HOME}/.zcompdump(#qN.mh+24) ]] && compinit || compinit -C;

## Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

bindkey "^[[3~" delete-char
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

export TERM="rxvt-256color"
export EDITOR="nano"
export GREP_COLORS='ms=01;33'

#source <(madonctl completion zsh)

## Transparent Xterm
#[ -n "$XTERM_VERSION" ] && transset-df -a 0.90 >/dev/null

## My Aliases
alias ls="ls -FshX --color=auto --group-directories-first"
alias less="less -R"
alias rm="rm -rf"
alias grep="grep --color=auto"
alias cpu="ps -eo pcpu,args --no-headers | sort -k 1 -r -n | head"
alias dmesg="dmesg -deL"
alias diff='colordiff -yZEwBd'
alias psc="ps xawf -eo pid,user,cgroup,args"
alias g+='echo -en "\xe2\x80\x8b" | xsel -i'
alias firefox='firejail --profile=/etc/firejail/firefox.profile --dns=9.9.9.9 --dns=1.1.1.1 --net=enp0s25 firefox-beta'
alias sudo='sudo '
alias icat='kitty +kitten icat'
alias chkspace='sudo du -hsx * | sort -rh | head'
alias mutt="abduco -A -e '^q' mutt /usr/bin/mutt"
alias mpv='mpv -wid=$(bspc query -N -n) $1'
alias mplay='DISPLAY=:0 xdotool key --window $(ps -aux | sed -n '/mp3/p' | grep -Eo "[0]x0.......") space'
alias mprev='DISPLAY=:0 xdotool key --window $(ps -aux | sed -n '/mp3/p' | grep -Eo "[0]x0.......") "94"'
alias mnext='DISPLAY=:0 xdotool key --window $(ps -aux | sed -n '/mp3/p' | grep -Eo "[0]x0.......") shift+"94"'
alias tl='trans -b'
alias tootr="madonctl toot --in-reply-to"
alias toot="madonctl toot"
alias boost="madonctl st boost -s"
alias fav="madonctl st favourite -s"
alias follow="madonctl accounts follow"
alias bw='w3m $1'
alias yt='mpv $1'

age () { sudo dumpe2fs $(mount | grep 'on \/ ' | awk '{print $1}') | grep 'Filesystem created:' }

used () { bat -n <(history 0 | awk '{ print $2}' | sort | uniq -c | sort -nr | head -n30) }

fullup () {
  yay -Syu --devel --needed --sudoloop --noconfirm --ignore $1 && pachist 60 && arch-audit | \
  colout '(Package) (.*) (is.*) (Medium|Low) (.*)|(Package) (.*) (is.*) (High) (.*)' black,yellow,black,yellow,black,black,yellow,black,red,black
}

export GPG_TTY=$(tty)

## Start the gpg-agent if not already running
#if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
#  gpg-connect-agent /bye >/dev/null 2>&1
#	gpg-agent --homedir $HOME/.gnupg --no-grab --allow-preset-passphrase --daemon
#fi

## Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

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

## mastodon
#conty() { printf '%s\n' "$(madonctl status show --template-file ansi-status.tmpl -s $1 --color on)" "$(madonctl status context --template-file ansi-context.tmpl -s $1 --color on)" }

## Look up cheat sheets for commands
cheat() {
      curl cht.sh/$1
  }

## Have I Been Pwned checker
hibp() {
        curl -fsS "https://haveibeenpwned.com/api/v2/breachedaccount/$1" | jq -r 'sort_by(.BreachDate)[] | [.Title,.Domain,.BreachDate,.PwnCount] | @tsv' | column -t -s$'\t'
}

##time in Stockholm
klocka () {
        curl -s https://www.timeanddate.com/worldclock/sweden/stockholm | awk -F'(<span id=ct class=h1>|</span>)' '/id=ct/{print $2}'
}

##Weather forcast via nixCraft
wttr () {
	curl http://wttr.in/$1
}

vind () {
	[ "$1" = "v" ] && { curl -s 'http://opendata-download-metobs.smhi.se/explore/zip?parameterIds=3,4&stationId=180940&period=latest-day&includeMetadata=false' }
	[ "$1" = "r" ] && { curl -s 'http://opendata-download-metobs.smhi.se/explore/zip?parameterIds=21&stationId=189720&period=latest-day&includeMetadata=false' }
	echo
	awk -F';' '/;G/{ total += $5; count++ } END { print "Dag: "total/count }' <<<$(curl -s 'http://opendata-download-metobs.smhi.se/explore/zip?parameterIds=3,4&stationId=180940&period=latest-day&includeMetadata=false')
	awk -F';' '/;G/{ total += $5; count++ } END { print "Månad: "total/count }' <<<$(curl -s 'http://opendata-download-metobs.smhi.se/explore/zip?parameterIds=3,4&stationId=180940&period=latest-months&includeMetadata=false')
	awk -F';' '/;G/{ total += $5; count++ } END { print "Hist: "total/count }' <<<$(curl -s 'http://opendata-download-metobs.smhi.se/explore/zip?parameterIds=3,4&stationId=180940&period=corrected-archive&includeMetadata=false')
}

who_where () {
	wget -q -O - "http://ip-api.com/csv/$1?fields=262143" | \
	awk -F',' '{print "City: "$6", "$5"\nCountry: "$2"\nIP-number: "$17" / "$11"\nMobile/Proxy: "$15" / "$16"\nPosition: "$8", "$9}' | \
	sed 's/"//g'
}

## Make screencast or convert to yt
ffsc () {

vid_name="$HOME/Videos/Screencasts/screencast_$(date +'%y%m%d-%H%M%S')"

        case $1 in
                sc) ffmpeg -f x11grab -s 1920x1080 -i $DISPLAY -r 30 -f pulse -i default -preset ultrafast \
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
#                mini) ffmpeg -i $2 -strict -2 -s 1280x720  -r 60 -c:v libx264 -b:v 164 -crf 22 -preset slow \
                mini) ffmpeg -i $2 -strict -2 -s 1680x1050  -r 60 -c:v libx264 -b:v 164 -crf 22 -preset slow \
		      -pix_fmt yuv420p -c:a copy -an ${2/scr/mini_scr}
		      mini_name=${2/scr/mini_scr}
		      ffmpeg -i ${mini_name} -filter:v "setpts=0.5*PTS" -an ${mini_name/.mkv/.mp4}
#		      ffmpeg -i ${mini_name} -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" ${mini_name/.mkv/.mp4}
		      rm ${mini_name}
		    printf "${mini_name/.mkv/.mp4}" | xsel -i
                    echo
                    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                    echo "Output file name: ${mini_name/.mkv/.mp4}"
                    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                    echo
                ;;
        esac
}

# Python as a calculator
pc() { python -c "print($*)"; } 

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
	  *.xz)        unxz $1	      ;;
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


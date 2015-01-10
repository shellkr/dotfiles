## Set up the prompt

autoload -Uz compinit promptinit
autoload -Uz colors && colors
autoload -U bashcompinit
compinit
bashcompinit
promptinit
prompt adam1
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}][%{$fg_no_bold[yellow]%}%T%{$reset_color%}]"

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

## Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

export EDITOR="nano"
export GREP_COLORS='ms=01;33'

eval "$(dircolors -b)"
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _match _correct _approximate
#zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' menu select=long
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

for sd_cmd in systemctl systemd-analyze systemd-run; do
    alias $sd_cmd='DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/dbus/user_bus_socket" '$sd_cmd
done

if [ -f "${HOME}/.gpg-agent-info" ]; then
	. "${HOME}/.gpg-agent-info"
	export GPG_AGENT_INFO
#	export SSH_AUTH_SOCK
fi

[ -r /usr/share/doc/pkgfile/command-not-found.zsh ] && . /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## My Aliases
alias ls="ls -FshX --color=auto --group-directories-first"
alias rm="rm -rf"
alias grep="grep --color=auto"
alias printmaint="cngpij -P Canon-MG5200-series_2C-9E-FC-09-C3-AB"
alias printstat="cngpijmonmg5200 Canon-MG5200-series_2C-9E-FC-09-C3-AB"
alias cpu="ps -eo pcpu,args --no-headers | sort -k 1 -r -n | head"
alias mem="free -m | awk '/che:/ {print \$3\" total used\n\"\$4\" total left\"}' && echo && ps -eu 1000 k rss -o rss,args | \sort -r -n | awk '{print \$1/1024\"\tMB - \"\$2,\$3,\$4,\$5,\$6,\$7,\$8}' | colout '([0-9].*)(\tMB)(.*)' blue,black,yellow | head"
alias memp="ps -eo pmem,args | sort -k 1 -r -n | ccze -m ansi | head"
alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"
alias dmesg="dmesg -deL"
alias diff='colordiff -yZEwBd'
alias psc="ps xawf -eo pid,user,cgroup,args"
alias fullupn='yaourt -Syua --devel --noconfirm'
alias fullup='yaourt -Syua --devel'
alias klocka="echo \$(curl -s http://www.frokenur.nu/|grep -oE \('id=.?hours[^<>]*>[^<>]+'\|'id=.?minutes[^<>]*>[^<>]+'\|'id=.?seconds[^<>]*>[^<>]+'\)| cut -d'>' -f2)"
alias yaourt="YAOURT_COLORS='other=1;30:pkg=0;33' yaourt"
alias rmpop="ls -d -1tr /tmp/Popcorn-Time/* | head -n -2 | cut -d' ' -f2- | xargs -d '\n' rm -rv"

## EXTRACT FUNCTION ##
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

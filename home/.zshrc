## Set up the prompt

autoload -Uz compinit promptinit
autoload -Uz colors && colors
compinit
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
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

export EDITOR="nano"
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33' 

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


[ -r /usr/share/doc/pkgfile/command-not-found.zsh ] && . /usr/share/doc/pkgfile/command-not-found.zsh
tmux has -t Weechat 1&>2 > /dev/null || tmux -2 -u new -d -s Weechat weechat-curses
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## My Aliases
alias ls="ls --color=auto -FshX"
alias sshn='ssh -XC -p 22273 -L 5900:localhost:5900 naima -t "tmux attach -t Naima -d || tmux -2 -u new -s Naima"'
alias weechat='tmux attach -t Weechat || tmux -2 -u new -s Weechat weechat-curses'
alias printstat="cngpij -P Canon-MG5200-series_2C-9E-FC-09-C3-AB"
#alias CopyCmd="CopyCmd Cloud -password=\"$(pass cloud/copy.com)\" -username=sandmanie@hotmail.com"
alias df="dfc -T"
alias cpu="ps -eo pcpu,args --no-headers | sort -k 1 -r -n | ccze -m ansi | head"
alias mem="free -m | awk '/che:/ {print \$3\" total used\n\"\$4\" total left\"}' && echo && ps -eo rss,args | \
sort -r -n | awk '{print \$1/1024\" MB - \"\$2\" \"}' | column -t | ccze -m ansi | head"
alias memp="ps -eo pmem,args | sort -k 1 -r -n | ccze -m ansi | head"
alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"

#!/bin/bash

cd ~/.cache/rtorrent/torrents/ || exit    # set your watch directory here
[[ "$1" =~ xt=urn:btih:([^&/]+) ]] || exit
hashh=${BASH_REMATCH[1]}
[[ "$1" =~ dn=([^&/]+) ]] && filename=${BASH_REMATCH[1]} || filename=$hashh
filename=${filename,,}
echo "d10:magnet-uri${#1}:${1}e" > "meta-$filename.torrent"


#!/bin/zsh

## The temperature is fetched from the free Norwegian forcast service Yr.no. Change the wurl variable to
## correspond with your location. Your ip can be blocked if you try to fetch the forecast too quick. So
## use an interval longer than 10 minutes.

wurl="http://www.yr.no/place/Sweden/Norrbotten/Ala_Lombolo/forecast.xml"

winfo=$(curl -s $wurl | egrep '(temperature|symbol)' | \
awk -F'="|"' '{printf $4","}' | cut -d "," -f 1-4)

[ "grep -i '^Partly cloudy$' <<<$winfo" ] && winfo=$(sed 's/Partly cloudy/\\u2601/g' <<<"$winfo")
[ "grep -i '^Fair$' <<<$winfo" ] && winfo=$(sed 's/Fair/\\u2600/g' <<<"$winfo")
[ "grep -i '^Rain$' <<<$winfo" ] && winfo=$(sed 's/Rain/\\u2602/g' <<<"$winfo")
[ "grep -i '^Heavy Rain$' <<<$winfo" ] && winfo=$(sed 's/Heavy Rain/\\u2614/g' <<<"$winfo")

awk -F"," '{print $2"°C",$1"  "$4"°C",$3}' <<<$winfo

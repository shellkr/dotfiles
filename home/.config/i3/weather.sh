#!/bin/zsh

## The temperature is fetched from the free Norwegian forcast service Yr.no. Change the wurl variable to
## correspond with your location. Your ip can be blocked if you try to fetch the forecast too quick. So
## use an interval longer than 10 minutes.

wurl="http://www.yr.no/place/Sweden/Norrbotten/Ala_Lombolo/forecast.xml"

winfo=$(curl -s $wurl | egrep '(temperature|symbol)' | \
awk -F'="|"' '{printf $4","}' | cut -d "," -f 1-4)

[ "grep -i '^Cloudy$' <<<$winfo" ] && winfo=$(sed 's/Cloudy/\\u2601/g' <<<"$winfo")
[ "grep -i '^Partly cloudy$' <<<$winfo" ] && winfo=$(sed 's/Partly cloudy/\\u2601/g' <<<"$winfo")
[ "grep -i '^Fair$' <<<$winfo" ] && winfo=$(sed 's/Fair/\\u2600/g' <<<"$winfo")
[ "grep -i '^Rain$' <<<$winfo" ] && winfo=$(sed 's/Rain/\\u2602/g' <<<"$winfo")
[ "grep -i '^Rain showers$' <<<$winfo" ] && winfo=$(sed 's/Rain showers/\\u2602/g' <<<"$winfo")
[ "grep -i '^showers and thunder$' <<<$winfo" ] && winfo=$(sed 's/showers and thunder/\\u2602\\u26a1/g' <<<"$winfo")
[ "grep -i '^Heavy rain$' <<<$winfo" ] && winfo=$(sed 's/Heavy rain/\\u2614\\u26a0/g' <<<"$winfo")

awk -F"," '{print $2"°C",$1"  "$4"°C",$3}' <<<$winfo

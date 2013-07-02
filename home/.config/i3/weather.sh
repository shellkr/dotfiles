#!/bin/zsh

## The temperature is fetched from the free Norwegian forcast service Yr.no. Change the wurl variable to
## correspond with your location. Your ip can be blocked if you try to fetch the forecast too quick. So
## use an interval longer than 10 minutes.

wurl="http://www.yr.no/place/Sweden/Norrbotten/Ala_Lombolo/forecast.xml"

winfo=$(curl -s $wurl | egrep '(temperature|symbol)' | \
awk -F'="|"' '{printf $4","}' | cut -d "," -f 1-4)

awk -F"," '{print $2"°C",$1" | "$4"°C",$3}' <<<$winfo

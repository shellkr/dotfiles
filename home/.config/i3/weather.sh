#!/bin/zsh

winfo=$(curl -s http://www.yr.no/place/Sweden/Norrbotten/Ala_Lombolo/forecast.xml | egrep '(temperature|symbol)' | \
awk -F'="|"' '{printf $4","}' | cut -d "," -f 1-4)

awk -F"," '{print $2"°C",$1" | "$4"°C",$3}' <<<$winfo

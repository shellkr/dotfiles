#!/bin/zsh

## The temperature is fetched from the free Norwegian forcast service Yr.no. Change the wurl variable to
## correspond with your location. Your ip can be blocked if you try to fetch the forecast too quick. So
## use an interval longer than 10 minutes.

##  1 = Clear sky
##  2 = Fair
##  3 = Partly cloudy
##  4 = Cloudy
##  5 = Rain showers
##  6 = Rain showers and thunder
##  9 = Rain
## 10 = Heavy rain
## 15 = Fog
## 22 = Rain and thunder
## 40 = Light rain showers
## 41 = Heavy rain showers
## 46 = Light rain

wurl="http://www.yr.no/place/Sweden/Norrbotten/Ala_Lombolo/forecast.xml"

winfo=$(curl -s $wurl | awk -F'="|"' '/(temperature|symbol)/{print $4}')

#We want the new-line to remain
old_ifs=${IFS}
IFS=$'
'

for i in $(awk 'ORS=NR%2?",":"\n"' <<<"$winfo" | awk -F"," '{print $2"C",$1}');
do

	case "$(cut -d' ' -f2 <<<$i)" in
		1|2) awk 'sub(/C.*/, "°C \\u2600")' <<<$i ;; # Sunny
		3|4) awk 'sub(/C.*/, "°C \\u2601")' <<<$i ;; # Clody
		5|9|10|40|41|46) awk 'sub(/C.*/, "°C \\u2602")' <<<$i ;; # Rainy
		6|22) awk 'sub(/C.*/, "°C \\u2602\\u26a1")' <<<$i ;; # Thunder
		15) awk 'sub(/C.*/, "°C f")' <<<$i ;; # fog
		*) echo "n/a ($i)" ;;
	esac

done

IFS=${old_ifs}



#awk -F"," '{print $2"°C",$1"  "$4"°C",$3}' <<<$winfo

#[ "grep -i '^Cloudy$' <<<$winfo" ] && winfo=$(sed 's/Cloudy/\\u2601/g' <<<"$winfo")
#[ "grep -i '^Partly cloudy$' <<<$winfo" ] && winfo=$(sed 's/Partly cloudy/\\u2601/g' <<<"$winfo")
#[ "grep -i '^Fair$' <<<$winfo" ] && winfo=$(sed 's/Fair/\\u2600/g' <<<"$winfo")
#[ "grep -i '^Clear sky$' <<<$winfo" ] && winfo=$(sed 's/Clear sky/\\u2600/g' <<<"$winfo")
#[ "grep -i '^Rain$' <<<$winfo" ] && winfo=$(sed 's/Rain/\\u2602/g' <<<"$winfo")
#[ "grep -i '^Rain showers$' <<<$winfo" ] && winfo=$(sed 's/Rain showers/\\u2602/g' <<<"$winfo")
#[ "grep -i '^showers and thunder$' <<<$winfo" ] && winfo=$(sed 's/showers and thunder/\\u2602\\u26a1/g' <<<"$winfo")
#[ "grep -i '^Heavy rain$' <<<$winfo" ] && winfo=$(sed 's/Heavy rain/\\u2614\\u26a0/g' <<<"$winfo")
#[ "grep -i '^Snow$' <<<$winfo" ] && winfo=$(sed 's/Snow/\\u2744/g' <<<"$winfo")


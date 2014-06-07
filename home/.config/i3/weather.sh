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

declare -a fcasts

wurl="http://www.yr.no/place/Sweden/Norrbotten/Ala_Lombolo/forecast.xml"

winfo=$(curl -s $wurl | awk -F'="|"' '/(temperature|symbol)/{print $4}')

#We want the new-line to remain
old_ifs=${IFS}
IFS=$'
'

for i in $(awk 'ORS=NR%2?",":"\n"' <<<"$winfo" | awk -F"," '{print $2"C",$1}');
do

	case "$(cut -d' ' -f2 <<<$i)" in
		1|2) fcast=$(awk 'sub(/C.*/, "°C \\u2600")' <<<$i) ;; # Sunny
		3|4) fcast=$(awk 'sub(/C.*/, "°C \\u2601")' <<<$i) ;; # Clody
		5|9|10|40|41|46) fcast=$(awk 'sub(/C.*/, "°C \\u2602")' <<<$i) ;; # Rainy
		6|22) fcast=$(awk 'sub(/C.*/, "°C \\u2602\\u26a1")' <<<$i) ;; # Thunder
		15) fcast=$(awk 'sub(/C.*/, "°C f")' <<<$i) ;; # fog
		*) echo "n/a ($i)" ;;
	esac

	fcasts+=( $fcast )

done

IFS=${old_ifs}

echo ${fcasts[@]:0:2} # how many forcast we want to show

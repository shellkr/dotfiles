#!/bin/zsh

## The temperature is fetched from the free Norwegian forcast service Yr.no. Change the wurl variable to
## correspond with your location. Your ip can be blocked if you try to fetch the forecast too quick. So
## use an interval longer than 10 minutes.

## 1 = Clear sky
## 2 = Fair
## 3 = Partly cloudy
## 4 = Cloudy
## 5 = Rain showers
## 9 = Rain
## 15 = Fog
## 41 = Heavy rain showers

wurl="http://www.yr.no/place/Sweden/Norrbotten/Ala_Lombolo/forecast.xml"

#winfo=$(curl -s $wurl | awk -F'="|"' '/(temperature|symbol)/{printf $4","}')
winfo=$(curl -s $wurl | awk -F'="|"' '/(temperature|symbol)/{print $4}')

wcond=$(awk 'ORS=NR%2?",":"\n"' <<<"$winfo" | awk -F"," '{print $1}')
wtemp=$(awk 'ORS=NR%2?",":"\n"' <<<"$winfo" | awk -F"," '{print $2}')

for i in $(awk 'ORS=NR%2?",":"\n"' <<<"$winfo" | awk -F"," '{print $1}');
do
#
#t="$wtemp"
#
#	if [[ $i = (1|2) ]]; then
#		i="\\u2600"
#	elif [[ $i = (3|4) ]]; then
#		i="\\u2601"
#	elif [[ $i = (5|9|41) ]]; then
#		i="\\u2602"
#	elif [[ $i = "15" ]]; then
#		i="fog"
#	else
#		echo "not found"
#	fi

#done

#awk 'ORS=NR%2?",":"\n"' <<<"$winfo" | awk -F"," '{print $2"°C \\'$i'"}'

	case "$i" in
		1|2) echo "1" ;;
		3|4) echo "3" ;;
		5|9|41) echo "5" ;;
		6) echo "6" ;;
		7) echo "7" ;;
		8) echo "8" ;;
		10) echo "10" ;;
		11) echo "11" ;;
		12) echo "12" ;;
		13) echo "13" ;;
		14) echo "14" ;;
		15) echo "15 fog" ;;
		*) echo "not recognized" ;;
	esac

done

#if [ "grep -i '^[1-2]$' <<<$winfo" ]; then
#	winfo=$(sed 's/[0-9]/\\u2600/1;s/[0-9]/\\u2600/6' <<<"$winfo")
#elif [ "grep -i '^[3-4]$' <<<$winfo" ]; then
#	winfo=$(sed 's/[0-9]/\\u2601/1;s/[0-9]/\\u2601/6' <<<"$winfo")
#elif [ "grep -i '^[9]$' <<<$winfo" ]; then
#	winfo=$(sed 's/[0-9]/\\u2602/1;s/[0-9]/\\u2602/6' <<<"$winfo")
#else
#	winfo="N/A"
#fi

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


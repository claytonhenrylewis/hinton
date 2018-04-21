#!/bin/bash

touch train_set_order.csv
touch eval_set_order.csv
input="genusImages.txt"
currentGenus=""
currentOrder=""
include="no"
while IFS= read -r var
do
	genus=$(echo $var | awk -F'/' '{print $7}')
	img=$(echo $var | awk -F'/' '{print $8}')
	num=$(echo $img | awk -F'-' '{print $2}')
	if [ "$genus" != "$currentGenus" ]
	then
		#count=$(grep "$genus," classCounts.csv | awk -F',' '{print $2}')
		currentGenus=$genus
		echo "$currentGenus"
		currentOrder=$(grep $genus orders/*/* -s | awk -F'/' '{print $2}')
	fi
	if [ "$genus" == "$currentGenus" ]
	then
		if (( ${#img} > 1 ))
		then
			if [[ $num == 9* ]] || [[ $num == 8* ]]
			then
				echo "$var,$currentOrder" >> eval_set_order.csv
			else
				echo "$var,$currentOrder" >> train_set_order.csv
			fi
		fi
	fi
done < "$input"

#!/bin/bash

touch train_set.csv
input="genusImages.txt"
currentGenus=""
include="no"
while IFS= read -r var
do
	genus=$(echo $var | awk -F'/' '{print $7}')
	img=$(echo $var | awk -F'/' '{print $8}')
	num=$(echo $img | awk -F'-' '{print $3}')
	if [ "$genus" != "$currentGenus" ]
	then
		if grep -Fxq "$genus" beeGenera.txt
		then
			count=$(grep "$genus," classCounts.csv | awk -F',' '{print $2}')
			if (( count > 100 ))
			then
				include="yes"
			else
				include="no"
			fi
		else
			include="no"
		fi
		currentGenus=$genus
		echo "$currentGenus, $count, $include"
	fi
	if [ "$genus" == "$currentGenus" ]
	then
		if [ "$include" == "yes" ]
		then
			if (( ${#img} > 1 ))
			then
				#echo "$var,$genus" >> train_set.csv
				#echo "$var,$genus"
				#echo "$img,$num"
				if [[ $num == 9* ]] || [[ $num == 8* ]]
				then
					echo "$var,$genus" >> eval_set_bees.csv
				else
					echo "$var,$genus" >> train_set_bees.csv
				fi
			fi
		fi
	fi
done < "$input"

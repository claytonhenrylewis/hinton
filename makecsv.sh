#!/bin/bash

touch train_set.csv
input="speciesImages.txt"
currentGenus=""
include="no"
while IFS= read -r var
do
	genus=$(echo $var | awk -F'/' '{print $7}')
	img=$(echo $var | awk -F'/' '{print $9}')
	num=$(echo $img | awk -F'-' '{print $3}')
	if [ "$genus" != "$currentGenus" ]
	then
		count=$(grep "$genus," classCounts.csv | awk -F',' '{print $2}')
		if (( count > 10000 ))
		then
			include="yes"
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
					echo "$var,$genus" >> eval_set.csv
				else
					echo "$var,$genus" >> train_set.csv
				fi
			fi
		fi
	fi
done < "$input"

#!/bin/bash

touch eval_set.csv
input="genusImages.txt"
while IFS= read -r var
do
	genus=$(echo $var | awk -F'/' '{print $7}')
	img=$(echo $var | awk -F'/' '{print $8}')
	if [ "$genus" != "$currentGenus" ]
	then
		count=$(grep "$genus," classCounts.csv | awk -F',' '{print $2}')
		if (( count > 499 ))
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
				echo "$var,$genus" >> eval_set.csv
				#echo "$var,$genus"
			fi
		fi
	fi
done < "$input"

#!/bin/bash

touch label.txt
input="classCounts.csv"
while IFS= read -r var
do
	genus=$(echo $var | awk -F',' '{print $1}')
	count=$(echo $var | awk -F',' '{print $2}')
	if (( count > 499 ))
	then
		echo "$genus" >> label.txt
		
	fi
done < "$input"

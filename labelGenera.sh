#!/bin/bash

input="genera.txt"
touch genera-unlabeled.txt
touch genus-family-order.csv
while IFS= read -r var
do
	genus=$(echo $var | awk -F'/' '{print $7}')
	order=$(grep $genus orders/*/*-genera.txt -s -w | head -1 | awk -F'/' '{print $2}')
	family=$(grep $genus orders/*/*/*/*-genera.txt -s -w | head -1 | awk -F'/' '{print $4}')
	if (( ${#order} > 1 ))
	then
		echo "$genus,$family,$order" >> genus-family-order.csv
	else
		echo "$genus" >> genera-unlabeled.txt
	fi	
done < "$input"

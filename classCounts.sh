#!/bin/bash

input="train_set_order_sorted.csv"
current=""
count=0
while IFS= read -r var
do
	genus=$(echo $var | awk -F',' '{print $2}')
	if [ "$genus" == "$current" ]; then
		((count++))
	else
		echo "$current,$count"
		current=$genus
		count=1
	fi
done < "$input"

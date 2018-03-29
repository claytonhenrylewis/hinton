#!/bin/bash

input="label_10000.txt"
genus[0]=" "
i=0
while IFS= read -r var
do
	genus[i]=$var
	i=$((i+1))
done < "$input"

min=-1
i=-5
while read line; do
	for word in $line; do
		if (( i > -1 ));
		then
			echo "$i ${genus[i]} $word"
		else
			echo "$word"
		fi
		i=$((i+1))
	done
done

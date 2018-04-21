#!/bin/bash

input="genusImages.txt"
currentGenus=""
currentFamily=""
currentOrder=""
touch train_set_order.csv
touch eval_set_order.csv
touch train_set_family.csv
touch eval_set_family.csv
touch train_set_genus.csv
touch eval_set_genus.csv

while IFS= read -r var
do
	genus=$(echo $var | awk -F'/' '{print $7}')
	img=$(echo $var | awk -F'/' '{print $8}')
	num=$(echo $img | awk -F'-' '{print $2}')
	if [ "$genus" != "$currentGenus" ]
	then
		currentGenus=$genus
		currentOrder=$(grep $currentGenus orders/*/*-genera.txt -s -w | head -1 | awk -F'/' '{print $2}')
		currentFamily=$(grep $currentGenus orders/*/*/*/*-genera.txt -s -w | head -1 | awk -F'/' '{print $4}')
		echo "Order: $currentOrder"
		echo "Family: $currentFamily"
		echo "Genus: $currentGenus"
		if (( ${#currentOrder} > 1 ))
		then	
			touch "orders/$currentOrder/eval_set_family.csv"
			touch "orders/$currentOrder/eval_set_genus.csv"
			touch "orders/$currentOrder/eval_set_species.csv"
			touch "orders/$currentOrder/train_set_family.csv"
			touch "orders/$currentOrder/train_set_genus.csv"
			if (( ${#currentFamily} > 1 ))
			then
				touch "orders/$currentOrder/families/$currentFamily/eval_set_genus.csv"
				touch "orders/$currentOrder/families/$currentFamily/train_set_genus.csv"
			fi
		fi
	fi
	if [ "$genus" == "$currentGenus" ]
	then
		if (( ${#img} > 1 ))
		then
			if [[ $num == 9* ]] || [[ $num == 8* ]]
			then
				echo "$var,$currentGenus" >> eval_set_genus.csv
			else
				echo "$var,$currentGenus" >> train_set_genus.csv
			fi
			if (( ${#currentOrder} > 1 ))
			then	
				if (( ${#currentFamily} > 1 ))
				then
					if [[ $num == 9* ]] || [[ $num == 8* ]]
					then
						echo "$var,$currentOrder" >> eval_set_order.csv
						echo "$var,$currentFamily" >> eval_set_family.csv
						echo "$var,$currentFamily" >> "orders/$currentOrder/eval_set_family.csv"
						echo "$var,$currentGenus" >> "orders/$currentOrder/eval_set_genus.csv"
						echo "$var,$currentGenus" >> "orders/$currentOrder/families/$currentFamily/eval_set_genus.csv"
					else
						echo "$var,$currentOrder" >> train_set_order.csv
						echo "$var,$currentFamily" >> train_set_family.csv
						echo "$var,$currentFamily" >> "orders/$currentOrder/train_set_family.csv"
						echo "$var,$currentGenus" >> "orders/$currentOrder/train_set_genus.csv"
						echo "$var,$currentGenus" >> "orders/$currentOrder/families/$currentFamily/train_set_genus.csv"	
					fi
				fi
			fi
		fi
	fi
done < "$input"

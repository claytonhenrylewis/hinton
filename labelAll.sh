#!/bin/bash

input="speciesImages.txt"
currentSpecies=""
currentGenus=""
currentFamily=""
currentOrder=""
include="no"
rm train_set_order.csv
rm eval_set_order.csv
rm train_set_family.csv
rm eval_set_family.csv
rm train_set_genus.csv
rm eval_set_genus.csv
rm orders/*/train_set_family.csv
rm orders/*/eval_set_family.csv
rm orders/*/train_set_genus.csv
rm orders/*/eval_set_genus.csv
rm orders/*/train_set_species.csv
rm orders/*/eval_set_species.csv
rm orders/*/*/*/train_set_genus.csv
rm orders/*/*/*/eval_set_genus.csv
rm orders/*/*/*/train_set_species.csv
rm orders/*/*/*/eval_set_species.csv
touch train_set_order.csv
touch eval_set_order.csv
touch train_set_family.csv
touch eval_set_family.csv
touch train_set_genus.csv
touch eval_set_genus.csv

while IFS= read -r var
do
	species=$(echo $var | awk -F'/' '{print $8}')
	img=$(echo $var | awk -F'/' '{print $9}')
	num=$(echo $img | awk -F'-' '{print $3}')
	if [ "$species" != "$currentSpecies" ]
	then
		#count=$(grep "$genus," classCounts.csv | awk -F',' '{print $2}')
		currentSpecies=$species
		currentGenus=$(echo $var | awk -F'/' '{print $7}')
		currentOrder=$(grep $currentGenus orders/*/*-genera.txt -s -w | head -1 | awk -F'/' '{print $2}')
		currentFamily=$(grep $currentGenus orders/*/*/*/*-genera.txt -s -w | head -1 | awk -F'/' '{print $4}')
		echo "Order: $currentOrder"
		echo "Family: $currentFamily"
		echo "Genus: $currentGenus"
		echo "Species: $currentSpecies"
		if (( ${#currentOrder} > 1 ))
		then	
			touch "orders/$currentOrder/eval_set_family.csv"
			touch "orders/$currentOrder/eval_set_genus.csv"
			touch "orders/$currentOrder/eval_set_species.csv"
			touch "orders/$currentOrder/train_set_family.csv"
			touch "orders/$currentOrder/train_set_genus.csv"
			touch "orders/$currentOrder/train_set_species.csv"
			if (( ${#currentFamily} > 1 ))
			then
				touch "orders/$currentOrder/families/$currentFamily/eval_set_genus.csv"
				touch "orders/$currentOrder/families/$currentFamily/eval_set_species.csv"	
				touch "orders/$currentOrder/families/$currentFamily/train_set_genus.csv"
				touch "orders/$currentOrder/families/$currentFamily/train_set_species.csv"
				if (( ${#currentGenus} > 1 ))
				then	
					touch "orders/$currentOrder/families/$currentFamily/genera/$currentGenus/eval_set_species.csv"
					touch "orders/$currentOrder/families/$currentFamily/genera/$currentGenus/train_set_species.csv"
				fi
			fi
		fi
	fi
	if [ "$species" == "$currentSpecies" ]
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
						echo "$var,$currentSpecies" >> "orders/$currentOrder/eval_set_species.csv"
						echo "$var,$currentGenus" >> "orders/$currentOrder/families/$currentFamily/eval_set_genus.csv"
						echo "$var,$currentSpecies" >> "orders/$currentOrder/families/$currentFamily/eval_set_species.csv"	
						echo "$var,$currentSpecies" >> "orders/$currentOrder/families/$currentFamily/genera/$currentGenus/eval_set_species.csv"

					else
						echo "$var,$currentOrder" >> train_set_order.csv
						echo "$var,$currentFamily" >> train_set_family.csv
						echo "$var,$currentFamily" >> "orders/$currentOrder/train_set_family.csv"
						echo "$var,$currentGenus" >> "orders/$currentOrder/train_set_genus.csv"
						echo "$var,$currentSpecies" >> "orders/$currentOrder/train_set_species.csv"
						echo "$var,$currentGenus" >> "orders/$currentOrder/families/$currentFamily/train_set_genus.csv"	
						echo "$var,$currentSpecies" >> "orders/$currentOrder/families/$currentFamily/train_set_species.csv"	
						echo "$var,$currentSpecies" >> "orders/$currentOrder/families/$currentFamily/genera/$currentGenus/train_set_species.csv"
					fi
				fi
			fi
		fi
	fi
done < "$input"

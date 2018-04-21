#!/bin/bash

input="taxonomy.txt"
order="unknown"
family="unknown"
genus="unknown"
species="unknown"
mkdir orders
touch orders.txt
while IFS= read -r var
do
	echo $var
	rank=$(echo $var | awk '{print $1}')
	if [ "$rank" == "Order" ]
	then
		echo "- ORDER -"
		order=$(echo $var | awk '{print $2}')
		echo $order >> orders.txt
		mkdir orders/$order
		mkdir orders/$order/families
		touch orders/$order/$order-families.txt
	elif [ "$rank" == "Family" ]
	then
		echo "- FAMILY -"
		family=$(echo $var | awk '{print $2}')
		echo $family >> orders/$order/$order-families.txt
		mkdir orders/$order/families/$family
		mkdir orders/$order/families/$family/genera
		touch orders/$order/families/$family/$family-genera.txt
	elif [ "$rank" == "Genus" ]
	then
		echo "- GENUS -"
		genus=$(echo $var | awk '{print $2}')
		echo $genus >> orders/$order/families/$family/$family-genera.txt	
		echo $genus >> orders/$order/$order-genera.txt
		mkdir orders/$order/families/$family/genera/$genus
		touch orders/$order/families/$family/genera/$genus/$genus-species.txt
	elif [ "$rank" == "Species" ]
	then
		echo "- SPECIES -"
		species=$(echo $var | awk '{print $2}')
		echo $species >> orders/$order/families/$family/genera/$genus/$genus-species.txt
	fi
done < "$input"

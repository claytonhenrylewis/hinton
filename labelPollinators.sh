#!/bin/bash

input="train_set_order.csv"
rm train_set_order_pollinators.csv
touch train_set_order_pollinators.csv
while IFS= read -r var
do
	order=$(echo $var | awk -F',' '{print $2}')
	if [[ $order == "Coleoptera" ]] || [[ $order == "Diptera" ]] || [[ $order == "Hymenoptera" ]] || [[ $order == "Lepidoptera" ]]
	then
		echo $var >> train_set_order_pollinators.csv
	fi
done < "$input"

#!/bin/bash

input="eval_set_order.csv"
rm eval_set_order_pollinators.csv
touch eval_set_order_pollinators.csv
while IFS= read -r var
do
	order=$(echo $var | awk -F',' '{print $2}')
	if [[ $order == "Coleoptera" ]] || [[ $order == "Diptera" ]] || [[ $order == "Hymenoptera" ]] || [[ $order == "Lepidoptera" ]]
	then
		echo $var >> eval_set_order_pollinators.csv
	fi
done < "$input"

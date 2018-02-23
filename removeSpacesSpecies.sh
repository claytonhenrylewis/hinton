#!/bin/bash

input="speciesImages.txt"
while IFS= read -r var
do
	genus=$(echo $var | awk -F'/' '{print $7}' | awk '{print $3}')
	species=$(echo $var | awk -F'/' '{print $7}' | awk '{print $4}')
	img=$(echo $var | awk -F'/' '{print $8}')
	num=$(echo $img | awk -F'-' '{print $3}' | awk -F'.' '{print $1}' | tr -d '[:space:]')
	if (( ${#img} > 1 ))
	then
		gsutil mv "$var" "gs://bugoff-bucket1/hinton/Insecta/GenusSpecies/$genus/$species/$genus-$species-$num.jpg"
		echo "gs://bugoff-bucket1/hinton/Insecta/GenusSpecies/$genus/$species/$genus-$species-$num.jpg"
		echo ""
	fi
done < "$input"

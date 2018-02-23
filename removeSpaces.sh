#!/bin/bash

input="genusImages.txt"
while IFS= read -r var
do
	genus=$(echo $var | awk -F'/' '{print $7}')
	img=$(echo $var | awk -F'/' '{print $8}')
	num=$(echo $img | awk -F'-' '{print $2}' | awk -F'.' '{print $1}' | tr -d '[:space:]')
	if (( ${#img} > 1 ))
	then
		gsutil mv "$var" "gs://bugoff-bucket1/hinton/Insecta/Genus1/$genus/$genus-$num.jpg"
		#echo "gs://bugoff-bucket1/hinton/Insecta/Genus1/$genus/$genus-$num.jpg"
	fi
done < "$input"

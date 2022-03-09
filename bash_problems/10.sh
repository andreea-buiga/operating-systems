#!/bin/bash

curr_month=$(date +%b' '%Y)
IFS=$'\n'
for user in $(last -F | awk '{print $1, $5, $8}' | grep -E 'Apr 2021' | awk '{print $1}' | sort -r | uniq -c | sort -gr)
do
	#echo $user
	username=$(echo $user | awk '{print $2}')
	fullname=$(finger $username | awk 'NR==1{print $4, $6, $7}')
	sessionC=$(echo $user | awk '{print $1}')
	echo $sessionC $fullname
done

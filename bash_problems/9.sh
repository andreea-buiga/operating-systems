#!/bin/bash

dir=$1

if [ ! -d $dir ];
then
        echo Pass a valid directory
        exit 1
fi

declare -A files

for file in $(find $dir -type f );
do
        key="$(md5sum $file | awk "{print \$1}")$(echo $file | awk -F '/' "{print \$NF}")"
        files[$key]="${files[$key]}$file|"
done
for checksum in "${!files[@]}";
do
        nrOfLines=$(echo ${files[$checksum]} | awk -F '|' "{print NF}" )
        if [ $nrOfLines -gt 2 ];
        then
                printable=`echo ${files[$checksum]} | sed -E "s/\|/\n/g"`
                echo "$printable"
                echo
        fi
done

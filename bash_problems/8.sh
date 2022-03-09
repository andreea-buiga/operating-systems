#!/bin/bash

IFS=$'\n'

for fileS in $(df -BM | tail -n +2);
do
        size=$(echo $fileS | awk "{print \$2}" | tr -d 'M')
        usage=$(echo $fileS | awk "{print \$5}" | tr -d '%')
        if [ $size -lt 1024 ] || [ $usage -gt 80 ];
        then
                echo $fileS | awk "{print \$1}"
        fi
done

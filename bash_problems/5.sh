#!/bin/bash
dirs=$@

while true;
do
        for dang in $dirs;
        do
                IFS=$'\n'
                for process in $(ps -ef | grep -E "/$dang$")
                do
                        echo $(echo $process | awk "{print \$9}") process was killed
                        kill -9 $(echo $process | awk "{print \$2}")
                        #echo $process | gawk "{print \$2}"
                        #echo $process #| awk "{print $2}"
                        #sleep 5
                done
        done
        sleep 3
done

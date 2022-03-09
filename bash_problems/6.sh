#!/bin/bash
dir=$1
for file in $(find $dir -type f);
do
        if ls -l $file | grep -q -E "(.w.){3}";
        then
                echo $(ls -l $file | awk "{print \$9, \$1}")
                chmod a-w $file
                echo $(ls -l $file | awk "{print \$9, \$1}")

        fi
done

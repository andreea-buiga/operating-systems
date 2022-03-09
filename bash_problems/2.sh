dir=$1
count=0
for file in $(find $dir -type f | grep -E "\.c$");
do
        nrOfLines=$(cat $file | wc -l)
        if [ $nrOfLines -gt 500 ];
        then
                echo $file
                count=$((count+1))
        fi
        if [ $count -eq 2 ]
        then
                break
        fi
done


dir=$1

for file in $(find $dir -type f | grep -E "\.log$" );
do
        cat $file | sort > interm.txt
        cat interm.txt > $file
        rm interm.txt
done

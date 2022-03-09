dir=$1

for sl in $(find $dir -type l)
do
        if ! [ -e $sl ];
        then
                echo $sl points to a deleted file!
        fi
done


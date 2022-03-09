for user in $(who | sort | awk '{print $1}' | uniq);
do
        number=$(ps -ef | grep -E "^$user" | wc -l)
        echo $user $number
done


#!/bin/bash

file=$1

if [ ! -f $file ]
then
        echo Please pass a valid file
        exit 1
fi
contor=0
mails=""
for user in $(cat $file)
do
        if [ ! $contor -eq 0 ]
        then
                mails="$mails,"
        fi
        mails="$mails$user@scs.ubbcluj.ro"
        contor=$((contor+1))
done
echo $mails

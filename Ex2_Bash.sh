#!/bin/bash

if [ ! -f "./data.txt" ]
then
    # get the data payload (all lines w/o "#" at the beginning)
    echo 'Converting csv in txt'
    grep -v "^#" data.csv | tr ',' ' ' > data.txt
else
    echo 'The file data.txt already exists!'
fi

#Counting even numbers
Numbers=($(cat data.txt))
counter=0

for n in "${Numbers[@]}"
do
    if (( n%2==0 ))
    then
        ((counter++))
    fi
done
echo "The number of even numbers is $counter"
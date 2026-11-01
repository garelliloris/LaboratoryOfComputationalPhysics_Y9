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

#Filtering data with the given relation:
#`sqrt(X^2 + Y^2 + Z^2)` is greater or smaller than `100*sqrt(3)/2`
A=$(echo "100 * sqrt(3) / 2" | bc -l)
total=${#Numbers[@]}
gtA_count=0
ltA_count=0
for (( i=0; i<total; i+=6 ))
do
    x=${Numbers[i]}
    y=${Numbers[i+1]}
    z=${Numbers[i+2]}
    sum_q=$(echo "sqrt($x^2+$y^2+$z^2)" | bc -l)
    is_gt=$(echo "$sum_q>$A" | bc -l)
    if [ $is_gt -eq 1 ]
    then
        ((gtA_count++))
        echo "$x $y $z" >> gt_data.txt
    else
        ((ltA_count++))
        echo "$x $y $z" >> lt_data.txt
    fi
done
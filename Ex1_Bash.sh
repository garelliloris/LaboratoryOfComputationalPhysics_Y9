#!/bin/bash

echo "You are in "
pwd

if [ ! -d "./students" ]
then
    echo "the Directory ./students does not exist! Creating it"
    mkdir students
else
    echo "The students Directory already exists!"
fi

cd students

if [ ! -f "./students.csv" ]
then
    echo "the file ./students.csv does not exist! Downloading it from link"
    wget "https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv?dl=1" -O students.csv
else
    echo "The file students.csv already exists!"
fi

if [ ! -f "./PoD_students.csv" ]
then
    echo "the file ./PoD_students.csv does not exist! Creating the file"
    #grep "Master program" students.csv>PoD_students.csv 
    grep PoD students.csv>>PoD_students.csv 
else
    echo "The file PoD_students already exists!"
fi
if [ ! -f "./Physics_students.csv" ]
then
    echo "the file ./Physics_students.csv does not exist! Creating the file"
    #grep "Master program" students.csv>Physics_students.csv 
    grep Physics students.csv>>Physics_students.csv  
else
    echo "The file Physics_students already exists!"
fi	

initials=$(cut -c1 students.csv | sed '1d')
max_counter=0
for letter in {A..Z}
do
    counter=0
    for init in $initials
    do
        if [ "$init" = "$letter" ]
        then
            ((counter++))
        fi
    done
    if [ $counter -gt $max_counter ]
    then
    	max_counter=$counter
    	max_letter=$letter
    fi
    echo "Letter $letter: $counter students"
done
echo "The letter with most counts is $max_letter with $max_counter"

header=$(grep "Family" students.csv)
for g in {1..18}
do
	echo "$header" > "group_${g}.csv"
done

total_lines=$(wc -l < students.csv)
l=2
current_group=1
while [ $l -le $total_lines ]
do 
	current_line=$(sed -n "${l}p" students.csv)
	echo "$current_line" >> "group_${current_group}.csv"
	((current_group++))
	if [ $current_group -gt 18 ]
	then 
		current_group=1
	fi
	((l++))
done

echo "Separazione completata"

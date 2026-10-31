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
    echo "The file already exists!"
fi



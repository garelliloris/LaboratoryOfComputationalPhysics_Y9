#!/bin/bash

if [ ! -f "./data.txt" ]
then
    # get the data payload (all lines w/o "#" at the beginning)
    echo 'Converting csv in txt'
    grep -v "^#" data.csv | tr ',' ' ' > data.txt
else
    echo 'The file data.txt already exists!'
fi

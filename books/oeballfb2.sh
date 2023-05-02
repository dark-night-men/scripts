#!/bin/bash

echo INFO Args: "$@"

if  [[ -z $1 ]] ; then
    echo Directory must be specified.
    exit 21
fi

if ! [[ -d $1 ]] ; then
    echo Directory ${1} does not exist.
    exit 22
fi


SOURCE_DIR="$1"

#export OUTPUT_DIR=/home/zerg/export/DiskStation/books2/Фантастика/0_Шекли\ Роберт/ooo/
#export OUTPUT_DIR="$SOURCE_DIR/OEB/"
export OUTPUT_DIR="$SOURCE_DIR/html/"

#echo SOURCE_DIR= "$SOURCE_DIR"
#find "$SOURCE_DIR" -type f -iname '*.seded.txt' -exec sh -c \
find "$SOURCE_DIR" -type f -iname '*.fb2' -exec sh -c \
    ' export IFS=$'\n'

    bname=$(basename -- "$0")
    stripped_filename="${bname%.*}"
    stripped_path="${0%.*}"
    #echo stripped_path="$stripped_path"

    #DIRNAME=$(echo "$stripped_filename" | sed -re "s/\.//g")
    DIRNAME=$(echo "$stripped_path" | sed -re "s/\.//g")

    TDIR="$OUTPUT_DIR$DIRNAME"

    # echo book="$0"

    # echo TDIR= "$TDIR"
    # echo "\n"

    env LC_ALL=en_US.utf8 time --format="\n elapsed time %E \n"  ~/scripts/books/oeb.sh "$0" "$TDIR" 

    ' {} \; -print


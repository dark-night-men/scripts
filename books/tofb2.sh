#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi


echo "arg 1 $1"


cmd=(
env LC_ALL=en_US.utf8 time --format='%E'
/usr/bin/ebook-convert "$1" "$1.fb2"
    --pretty-print
    --enable-heuristics
    --verbose
    --change-justification left
    # --title="$2" --authors="$3"
    --embed-font-family  'Comfortaa'
    --minimum-line-height 70 
    --language ru
)

echo "Executing: "
printf "%q " "${cmd[@]}"
echo

"${cmd[@]}" 


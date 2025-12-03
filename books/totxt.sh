#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

echo "arg 1 $1"

/usr/bin/ebook-convert "$1" "$1.txt" --pretty-print --enable-heuristics --change-justification left

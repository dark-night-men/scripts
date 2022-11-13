#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

echo "arg 1 $1"

/usr/bin/ebook-convert "$1" "$1.docx" --pretty-print --enable-heuristics 

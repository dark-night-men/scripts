#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

echo "arg 1 $1"

#/usr/bin/txt2html --infile "$1" --outfile "$1.html" 

#/usr/bin/ebook-convert "$1" "$1.htmlz" --pretty-print --enable-heuristics 
/usr/bin/ebook-convert "$1" "$1.htmlz" --pretty-print --enable-heuristics --embed-font-family  'Monofur NF'

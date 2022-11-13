#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

echo "arg 1 $1"

#/usr/local/bin/wkhtmltopdf "$1" "$1.pdf"

#regular flow
#/usr/bin/ebook-convert "$1" "$1.fb2" --pretty-print --enable-heuristics --embed-font-family  'Monofur NF'
/usr/bin/ebook-convert "$1" "$1.lit" --verbose 

#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

echo "arg 1 $1"
echo "note arg 2 (if exist) means verbosity level 0 - by default '-v -v' - usable"

#/usr/local/bin/wkhtmltopdf "$1" "$1.pdf"

#regular flow
/usr/bin/ebook-convert "$1" "$1.epub" ${2:-} --pretty-print --enable-heuristics --embed-font-family  'Monofur NF'

#/usr/bin/ebook-convert "$1" .epub --pretty-print --enable-heuristics --embed-font-family  'Monofur NF' --no-default-epub-cover --epub-flatten --verbose -d debug

#merging flow
#export LC_ALL=en_US.utf8
#env LC_ALL=en_US.utf8 /usr/bin/ebook-convert  "$1" "$1.epub" --pretty-print --enable-heuristics --embed-font-family  'Monofur NF' --verbose -d debug

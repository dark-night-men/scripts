#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

echo "arg 1 $1"

#/usr/bin/ebook-convert "$1" "$1_clm.mobi" --pretty-print --enable-heuristics --filter-css font-family,color,margin-left,margin-right
#/usr/bin/ebook-convert "$1" "$1_clm.mobi" --pretty-print --enable-heuristics
/usr/bin/ebook-convert "$1" "$1_clm.mobi" --mobi-file-type new --pretty-print --enable-heuristics --verbose

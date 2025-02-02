#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

if [[ -z $2 ]]; then
    echo Second arg must be provided, as title.
    exit 2
fi

if [[ -z $3 ]]; then
    echo Third arg must be provided, as author\'s name.
    exit 3
fi

echo "arg 1 $1"

#/usr/bin/ebook-convert "$1" "$1_clm.mobi" --pretty-print --enable-heuristics --filter-css font-family,color,margin-left,margin-right
#/usr/bin/ebook-convert "$1" "$1_clm.mobi" --pretty-print --enable-heuristics
/usr/bin/ebook-convert "$1" "$1_ccf.mobi" --mobi-file-type new --pretty-print --enable-heuristics --verbose --change-justification left --title="$2" --authors="$3" --embed-font-family  'Comfortaa'

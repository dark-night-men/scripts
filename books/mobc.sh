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


env LC_ALL=en_US.utf8 time --format='%E' \
    /usr/bin/ebook-convert "$1" "$1_clm_c.mobi" --mobi-file-type new --verbose --title="$2" --authors="$3" 


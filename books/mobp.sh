#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

echo "arg 1 $1"
echo "note arg 2 (if exist) means title name. default title - filename"

#/usr/bin/ebook-convert "$1" "$1_clm.mobi" --pretty-print --enable-heuristics --filter-css font-family,color,margin-left,margin-right
#/usr/bin/ebook-convert "$1" "$1_clm.mobi" --pretty-print --enable-heuristics

# set -x

env LC_ALL=en_US.utf8 time --format='%E' \
/usr/bin/ebook-convert "$1" "$1_clp.mobi" --mobi-file-type new --verbose --title "${2:-$1}" --embed-font-family  'Monofur NF'

# set +x

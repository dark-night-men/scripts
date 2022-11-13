#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

echo "arg 1 $1"

export IFS=$'\n\t'
#export IFS=$'\n:'
set -x
calibre-debug --run-plugin EpubMerge -- -l ru $(paste -s "$1")
#calibre-debug --run-plugin EpubMerge -- -l ru $(paste -s -d':' "$1")
#calibre-debug --run-plugin EpubMerge -- -n -f -N -l ru $(head -n5 "$1" | paste -s )
#calibre-debug --run-plugin EpubMerge -- -l ru $(head -n5 "$1" | paste -s )
set +x

#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

if [[ -z $2 ]]; then
    echo Second arg must be provided, as name of dir without dots.
    exit 4
fi


if  [[ -d "$2" ]] ; then
    echo Dir "$2" should not exist. exit.
    exit 2
fi

#testseq="\."
testseq="^..*\."
if  [[ "$2" =~ $testseq ]] ; then
    echo Dir "$2" should not contain dots. exit.
    exit 3
fi

echo "arg 1 $1"
echo "arg 2 $2"

/usr/bin/ebook-convert "$1" "$2" --pretty-print --enable-heuristics --embed-font-family 'Roboto'

#set -x
#/usr/bin/ebook-convert "$1" "$2" --pretty-print --enable-heuristics --embed-font-family  'Monofur NF' --epub-flatten --verbose -d debug
#set +x



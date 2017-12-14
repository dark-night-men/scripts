#!/bin/bash

echo "Hello world"
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

echo "Arg1 : >$1<"
if [[ -z $1 ]] ; then
    echo "Arg 1 must be a filename. Exit."
    exit 1
else
    echo "Arg 1 provided. Ok."
fi

if ! [[ -e /tmp/tmp/ ]] ; then
    echo "/tmp/tmp does not exist. Creating /tmp/tmp"
    mkdir -p /tmp/tmp
else
    echo "/tmp/tmp already exists."
fi

echo "Copying files from list $1 to /tmp/tmp"

while read p; do
    mv -v  $p /tmp/tmp |& tee /tmp/mov.log
done < $1

IFS=$SAVEIFS

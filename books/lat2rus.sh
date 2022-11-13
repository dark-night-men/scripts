#!/bin/bash


export LAT2RUSF=/home/zerg/tmp/tmpscripts/books/lat2rus_f.sh

#find -mindepth 1 -maxdepth 1 -type d -exec sh -c '
find -mindepth 1 -maxdepth 1 -type f -iname '*.fb2' -exec sh -c '

mv -v  "$0" $( "$LAT2RUSF" "$0" )


' {} \; 


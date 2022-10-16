#!/bin/bash

if  [[ -z $1 ]] ; then
    echo File name must be specified.
fi

export IFS=$'\n'

ffmpeg -i "$1" -b:a 128k "${1%.*}"_new.ac3

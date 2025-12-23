#!/bin/bash

if  [[ -z $1 ]] ; then
    echo File name must be specified.
fi

export IFS=$'\n'

#96, 128, 160, 192, 256
QUALITY=${2-128k}
SUFFIX=_new.${QUALITY}.ru.ac3

env LC_ALL=en_US.utf8 time --format='%E' \
    ffmpeg -i "$1" -b:a $QUALITY "${1%.*}${SUFFIX}"

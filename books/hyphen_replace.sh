#!/bin/bash

find -maxdepth 1 -type f -not -iname '*.seded.txt' -iname '*.txt' -exec sh -c \
    ' export IFS=$'\n'

    sed  -re "s|\o302\o254\o040||g" "$0" > "$0".seded.txt
    ' {} \; -print


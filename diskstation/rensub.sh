#!/bin/bash

export IFS=$'\n'

find . -iname '*.avi' -exec sh -c \
    ' 
    export IFS=$IFS


    episode_number=$( echo $0 | /bin/grep -Poi "s\d\de\d\d" )


    if ! [ -z "$episode_number" ] ; then

        srt_file=$( ls -1 *.srt | grep $episode_number )

        if ! [ -z "$srt_file" ] ; then

            filename=$(basename -- "$0")
            filename="${filename%.*}"

            #rename -n -v '"'"'s/'"'"'${srt_file}'"'"'/'"'"'${filename}.srt'"'"'/'"'"' ${srt_file}
            mv -v ${srt_file} ${filename}.srt
        fi
    fi

    ' {} \;


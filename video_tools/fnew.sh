#!/bin/bash


export LC_ALL=en_US.utf8

while IFS= read -r -d $'\0'; do


    STRIPPED_ARG_PATH="${REPLY%_New.*}"
    REPLY_EXTENSION="${REPLY##*.}"


    if [ -f "$STRIPPED_ARG_PATH"\."$REPLY_EXTENSION" ]; then

        ls -lh "$STRIPPED_ARG_PATH"\."$REPLY_EXTENSION"
        ls -lh "$STRIPPED_ARG_PATH"_New\."$REPLY_EXTENSION"

        printf '\n'
    fi

done < <(find "${@-.}" -type f -regextype egrep -iregex '.*_New\.(mkv|avi|mp4|mpg|flv)' -print0)

#!/usr/bin/bash 

DIRS_LISTS="$1"

if ! [ -f $DIRS_LISTS ]; then
    echo File with dirs must be provided as first arg. exit.
    exit
else
    echo "$DIRS_LISTS" - file with dirs found.
fi


OUTPUT_DIR="$2"
if [ -d $OUTPUT_DIR ] || [ -z $OUTPUT_DIR ]; then
    echo Non-existent dir must be provided as second arg. exit.
    exit
else
    echo "$OUTPUT_DIR" - output dir name provided
fi


unset LINE_NUMBER
LINE_NUMBER=0

# echo "File $EXCLUDED_DIRS FOUND."

while IFS=  read -r -d $'\n'; do
    # echo Line "$REPLY"

    LINE=$(echo "$REPLY" | sed -re 's|^[[:space:]]+||')
    [[ ${LINE:0:1} == "#" ]] && continue

    LINE_NUMBER=$(expr $LINE_NUMBER + 1)

    echo "$LINE_NUMBER $LINE"

    if (( LINE_NUMBER == 1  )) ; then
        echo First line contsins video.
    else
        echo Line contains other stuffs.
    fi

    # ESCAPED_NAME=$(printf '%q' "$REPLY")

    #Consider lines with * metachar like lines with glob, then not escaping them.
    #Replacing \* to *
    # if echo "$REPLY" | grep -q '\*' ; then
    #     ESCAPED_NAME=$(echo $ESCAPED_NAME | sed -re 's|\\\*|*|g')
    # fi

    EXCLUDED_EXPR="$EXCLUDED_EXPR -not -path '*/$ESCAPED_NAME/*'"
    # EXCLUDED_EXPR="$EXCLUDED_EXPR -not -path "*/$ESCAPED_NAME/*"
done < "$DIRS_LISTS"

# echo EXCLUDED_EXPR "$EXCLUDED_EXPR"


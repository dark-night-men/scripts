#!/bin/bash


export LC_ALL=en_US.utf8

DEBUG_FLAG=DEFINED

if [[ -n $DEBUG_FLAG ]] ; then

    AUTOTMPDIR=/tmp
    trap 'set +x' EXIT
else

    AUTOTMPDIR="$(mktemp -d)"
    trap 'rm -rfv -- "$AUTOTMPDIR"' EXIT
fi


TEMPFILE="$AUTOTMPDIR"/raw_data.txt
[ -f $TEMPFILE ] && rm -v $TEMPFILE

#find output example:
#1330.915044     344M    /mnt/c/Users/serge/Videos/!heap/South Park/16 Sezon/04. Jewpacabra.avi

while IFS= read -r -d $'\0'; do


    FILE_DURATION_IN_SEC=$( ffprobe -i "$REPLY" -show_entries format=duration -v quiet -of csv="p=0")

    FILE_SIZE=$(du -sh "$REPLY"|awk '{print $1}')
    FILE_SIZE_IN_BYTES=$(echo "$FILE_SIZE"|numfmt --from iec)

    RATIO=$( echo "scale=2; $FILE_SIZE_IN_BYTES*3600/$FILE_DURATION_IN_SEC" | bc | numfmt --to iec )
    FILE_DURATION_HUMAN_RE=$(date -d@"$FILE_DURATION_IN_SEC" -u +%H:%M:%S)

    printf "%s %s %s %s\n" $RATIO $FILE_SIZE $FILE_DURATION_HUMAN_RE "$REPLY" >> $TEMPFILE



done < <(find "${@-.}" -type f -size +800M -regextype egrep -iregex '.*\.(mkv|avi|mp4|mpg|flv)' -print0)

sort -h -r $TEMPFILE

exit

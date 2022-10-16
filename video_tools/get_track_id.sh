#!/bin/bash

printf '%s \n' 'Hello World!'

export LC_ALL=en_US.utf8

if ! [[ -n $1 ]] ; then
    echo File must be specified.
fi


FILEFULLNAME=$1

INFO_LOG=/tmp/get_track_id.log

export IFS=$'\n'
mkvinfo $FILEFULLNAME > $INFO_LOG

PARSED_LOG=/tmp/get_track_id_parsed.log
NUMS_LOG=/tmp/get_track_id_nums.log
TYPES_LOG=/tmp/get_track_id_types.log

egrep 'Track number' $INFO_LOG | sed -E 's|^.*mkvextract: ([0-9]+)\)|\1|' > $NUMS_LOG
egrep 'Track type' $INFO_LOG | sed -E 's/^.*Track type: (video|audio|subtitles)/\1/'> $TYPES_LOG

TRACKS_NUMBER=$(wc -l < $NUMS_LOG)
TYPES_NUMBER=$(wc -l < $TYPES_LOG)

if [[ $TRACKS_NUMBER  -lt 1 ]] ; then
    printf 'Track numbers PROBLEM %i\n. Exiting.' "$TRACKS_NUMBER"
    exit 2
fi

if [[ $TYPES_NUMBER  -ne $TRACKS_NUMBER ]] ; then
    printf 'Tracks types %i and number %i mismatch.\n' "$TYPES_NUMBER" "$TRACKS_NUMBER"
    exit 3
fi


#skip video line
paste -d' ' $TYPES_LOG $NUMS_LOG | tail -n +2 > $PARSED_LOG

#rm -v $PARSED_LOG
#touch  $PARSED_LOG

FIRST_AUDIO=$(grep -q audio < "$PARSED_LOG" && grep audio < "$PARSED_LOG" | head -n1 | awk '{ print $2 }' )

if [[ -n "$FIRST_AUDIO"  ]] ; then

    LAST_AUDIO=$(grep -q audio < "$PARSED_LOG" && grep audio < "$PARSED_LOG" | tail -n1 | awk '{ print $2 }' )
fi

FIRST_SUB=$(grep -q subtitles < "$PARSED_LOG" && grep subtitles < "$PARSED_LOG" | head -n1 | awk '{ print $2 }' )

if [[ -n "$FIRST_SUB"  ]] ; then

    LAST_SUB=$(grep -q subtitles < "$PARSED_LOG" && grep subtitles < "$PARSED_LOG" | tail -n1 | awk '{ print $2 }' )
fi

if [[ -n $LAST_AUDIO && -n $LAST_SUB  \
    && ( ( $FIRST_SUB -gt $FIRST_AUDIO && $FIRST_SUB -lt $LAST_AUDIO ) \
      || ( $FIRST_AUDIO -gt $FIRST_SUB && $FIRST_AUDIO -lt $LAST_SUB) ) ]] ; then

    printf 'Interrupted tracks seq : first audio %i, last audio %i, first sub %i, last sub %i . Exit' $FIRST_AUDIO $LAST_AUDIO $FIRST_SUB $LAST_SUB
    exit 4
fi


exit

  #./mkvextract.exe tracks ~/Videos/TVShows/Avenue.5.S01.1080p.TVShows/Avenue.5.S01E02.1080p.TVShows.mkv 3:sub.srt | less


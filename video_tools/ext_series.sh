#!/bin/bash

export LC_ALL=en_US.utf8

#DEBUG_FLAG=DEFINED

if [[ -n $DEBUG_FLAG ]] ; then

    AUTOTMPDIR=/tmp
    trap 'set +x' EXIT
else

    AUTOTMPDIR="$(mktemp -d)"
    trap 'rm -rfv -- "$AUTOTMPDIR"' EXIT
fi

#echo Hello World

echo INFO Args: "$@"

if  [[ -z $1 ]] ; then
    echo Directory must be specified.
    exit 21
fi

if ! [[ -d $1 ]] ; then
    echo Directory ${1} does not exist.
    exit 22
fi

if  [[ -n $2 ]] && [[ $2 != "-r" ]]  ; then
    echo If you provide second arg it must be '-r'
    exit 23
fi

if [[ -n $2 ]] ; then
    RECURSIVE_FIND=true

    RECURSIVE_VALUE_1=""
    RECURSIVE_VALUE_2=""
else

    RECURSIVE_VALUE_1="-maxdepth"
    RECURSIVE_VALUE_2="1"
fi

export IFS=$'\n'

DIRPATH=$1


TEMPFILE="$AUTOTMPDIR"/tmp_mkvtool.txt

IFS_backup=$IFS

#export IFS=$'\n'

#set -x


#MKV_PATTERN="$DIRPATH/*.mkv"
#MKV_FILES=( $MKV_PATTERN )

#MKV_FILES=( $DIRPATH/*.mkv )

MKV_FILES=()
while IFS=  read -r -d $'\0'; do
    MKV_FILES+=("$REPLY")
done < <( find $DIRPATH $RECURSIVE_VALUE_1 $RECURSIVE_VALUE_2 -path '*/@eaDir/*' -prune -o -name '*.mkv' -print0)

#debug print array
printf '%s\n' "${MKV_FILES[@]}"

#Checking do we have at least single mkv file
if [ ${#MKV_FILES[@]} -lt 1 ]; then

    printf 'No mkv files in %s directory. Exit. If you whant recursive search use -r. \n' "$DIRPATH"
    exit 11
fi

printf 'First mkv file %s. \n' "${MKV_FILES[0]}"


#FILEFULLNAME=$1
FILEFULLNAME="${MKV_FILES[0]}"

INFO_LOG="$AUTOTMPDIR"/get_track_id.log

#export IFS=$'\n'
mkvinfo $FILEFULLNAME > $INFO_LOG

PARSED_LOG="$AUTOTMPDIR"/get_track_id_parsed.log
NUMS_LOG="$AUTOTMPDIR"/get_track_id_nums.log
TYPES_LOG="$AUTOTMPDIR"/get_track_id_types.log

egrep 'Track number' $INFO_LOG | sed -E 's|^.*mkvextract: ([0-9]+)\)|\1|' > $NUMS_LOG
egrep 'Track type' $INFO_LOG | sed -E 's/^.*Track type: (video|audio|subtitles)/\1/'> $TYPES_LOG

TRACKS_NUMBER=$(wc -l < $NUMS_LOG)
TYPES_NUMBER=$(wc -l < $TYPES_LOG)

if [[ $TRACKS_NUMBER  -lt 1 ]] ; then
    printf 'Track numbers PROBLEM %i. Exiting.\n' "$TRACKS_NUMBER"
    exit 2
fi

#set +x

if [[ $TYPES_NUMBER  -ne $TRACKS_NUMBER ]] ; then
    printf 'Tracks types %i and number %i mismatch.\n' "$TYPES_NUMBER" "$TRACKS_NUMBER"
    exit 3
fi


#skip video line
paste -d' ' $TYPES_LOG $NUMS_LOG | tail -n +2 > $PARSED_LOG

#cat $PARSED_LOG

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


if [[ -z $LAST_AUDIO && -z $LAST_SUB ]] ; then

    printf 'There is no audio or sub tracks. Exit.\n'

    exit 5
fi

  #./mkvextract.exe tracks ~/Videos/TVShows/Avenue.5.S01.1080p.TVShows/Avenue.5.S01E02.1080p.TVShows.mkv 3:sub.srt | less


#for x in $( ls -1 $DIRPATH/*.mkv ) ; do
#for x in "$DIRPATH"/*.mkv ; do
for x in "${MKV_FILES[@]}" ; do

    export IFS=$'\n'

    #echo $x
    rm -v $TEMPFILE

    if [[ -n $LAST_SUB ]]; then

        for subt_index in $(seq $FIRST_SUB $LAST_SUB ) ; do

            echo $subt_index:${x%.*}.$subt_index.srt >> $TEMPFILE
        done
    fi

    if [[ -n $LAST_AUDIO ]]; then

        for audio_index in $(seq $FIRST_AUDIO $LAST_AUDIO ) ; do

            echo $audio_index:${x%.*}.$audio_index.ac3 >> $TEMPFILE
        done
    fi


    #export IFS=$IFS_backup

    #Since we are using just \n as FS, result of $(paste ...) - the whole string - is considering as singe file name. WHen using default IFS movie file with spaces is splitting, so we need additional FS - '|' - that using in filenames rarely.
    export IFS=$'\n|'
    mkvextract tracks $x $(paste -sd'|' $TEMPFILE)

done

#set +x

exit

  #./mkvextract.exe tracks ~/Videos/TVShows/Avenue.5.S01.1080p.TVShows/Avenue.5.S01E02.1080p.TVShows.mkv 3:sub.srt | less

#!/bin/bash

#set -x
#set -e

export LC_ALL=en_US.utf8

#DEBUG_FLAG=DEFINED

if [[ -n $DEBUG_FLAG ]] ; then

    AUTOTMPDIR=/tmp
    trap 'set +x' EXIT
else

    AUTOTMPDIR="$(mktemp -d)"
    trap 'rm -rfv -- "$AUTOTMPDIR"' EXIT
fi

echo INFO Args: "$@"
echo basename $(basename -- "$1")

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

DURATION_FLOAT=$(  ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 "$1" )

#echo DURATION_FLOAT "$DURATION_FLOAT"

if ! [[ $DURATION_FLOAT =~ ^[+-]?[0-9]+\.?[0-9]*$  ]]; then
    echo "Video duration fail. Exit."
    exit 2
fi

#round to int "%.0f" - round to zero floating digits 
#we need en_US since ffprobe get result with dot delimiter whereas russian delimiter is comma
DURATION_ROUNDED=$( env LC_ALL=en_US.utf8 printf "%.0f\n" "$DURATION_FLOAT" )

#echo DURATION_ROUNDED "$DURATION_ROUNDED"

declare -a MARK_KINDS=( L1 L2 L3 L4)
declare -a ROW_MARKS=( L1 L1 L1 L1 L2 L2 L2 L2 L3 L3 L3 L3 L4 L4 L4 L4)

HALF_TIME=$((( DURATION_ROUNDED/2 )))

#l-30 l-60 l-90 l-120 l-150
declare -a TIME_POINTS=( 45 200 300 400\
    $((( HALF_TIME-600 ))) $((( HALF_TIME-400 ))) $((( HALF_TIME-200 ))) "$HALF_TIME" \
    $((( HALF_TIME + 200 ))) $((( HALF_TIME + 400 ))) $((( HALF_TIME + 600 )))\
    $((( DURATION_ROUNDED - 150 ))) $((( DURATION_ROUNDED - 120 )))\
    $((( DURATION_ROUNDED - 90 ))) $((( DURATION_ROUNDED - 60 ))) $((( DURATION_ROUNDED - 30 ))) )

if ! [[ "${#ROW_MARKS[*]}" == "${#TIME_POINTS[*]}"   ]]; then
    echo "Arrays mismatch. Exit."
    exit 3
fi


for index in "${!TIME_POINTS[@]}"; do
    #echo "$index - ${TIME_POINTS[$index]}"; 

    SUFFIX=$(printf "%05d" "${TIME_POINTS[index]}")
    #echo SUFFIX "$SUFFIX"

    EXTRACTED_BASENAME="$AUTOTMPDIR"/output_"${ROW_MARKS[index]}""$SUFFIX"
    EXTRACTED_FILENAME="$EXTRACTED_BASENAME".extracted.png

    # -n dont overwrite
    # -y force overwrite
    #ffmpeg -n -ss "$i" -i "$1" -vframes 1 "$AUTOTMPDIR"/output_"$i".png
    ffmpeg -hide_banner -loglevel error  -ss "${TIME_POINTS[index]}" -i "$1" -vframes 1 "$EXTRACTED_FILENAME" 

    RESIZED_FILENAME="$EXTRACTED_BASENAME".resized.png
    convert  -resize 20% "$EXTRACTED_FILENAME" "$RESIZED_FILENAME"

    #TIMETEXT=$(date -d@"${TIME_POINTS[index]}" -u +%H:%M:%S)'  '"$1"
    TIMETEXT=$(date -d@"${TIME_POINTS[index]}" -u +%H:%M:%S)

    ANNOTATED_FILENAME="$EXTRACTED_BASENAME"_ANNOTATED.png

    convert "$RESIZED_FILENAME" -undercolor Black -pointsize 15 -fill red  -gravity NorthEast -annotate 0 "$TIMETEXT"  "$ANNOTATED_FILENAME"

done


for mark_index in "${!MARK_KINDS[@]}"; do
    #echo "$mark_index" _  "${MARK_KINDS[$mark_index]}"
    convert "$AUTOTMPDIR"/output_"${MARK_KINDS[mark_index]}"*_ANNOTATED.png  +append "$AUTOTMPDIR"/output_"${MARK_KINDS[mark_index]}".png
done

convert "$AUTOTMPDIR"/output_L{1,2,3,4}.png -append "$AUTOTMPDIR"/output_tmp.png

convert "$AUTOTMPDIR"/output_tmp.png -undercolor Black -pointsize 2 -fill red  -gravity SouthEast -annotate 0 $(basename -- "$1") "$1".output.png



#TEMPFILE="$AUTOTMPDIR"/tmp_mkvtool.txt

exit 0

#ffmpeg -ss 00:01:19 -i input -vframes 1 output_01.png

#get video duration
#ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 input.mp4

#for i in $(seq 1 $END); do echo $i; done

#env LC_ALL=en_US.utf8 printf "%.3f\n" 678.789678


#Example (vertical sprite):
#convert image1.png image2.png image3.png -append result/result-sprite.png

#Example (horizontal sprite):
#convert image1.png image2.png image3.png +append result/result-sprite.png

#$ date -d@36 -u +%H:%M:%S
#00:00:36


#convert in.tif  -undercolor Black -pointsize 10 -fill yellow  -gravity SouthWest -annotate 0 'Text String' out.tif

#echo "${animals[moo]}"
#for sound in "${!animals[@]}"; do echo "$sound - ${animals[$sound]}"; done


exit 0


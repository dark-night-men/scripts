#!/bin/bash

#set -x
#set -e

export LC_ALL=en_US.utf8
export IFS=$'\n' 

echo INFO Args: "$@"

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--col)
      COLUMNS="$2"
      shift # past argument
      shift # past value
      ;;
    -w|--rows)
      ROWS="$2"
      shift # past argument
      shift # past value
      ;;
    --default)
      DEFAULT=YES
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters



COLUMNS="${COLUMNS:-4}" 
ROWS="${ROWS:-4}" 


#DEBUG_FLAG=DEFINED

if [[ -n $DEBUG_FLAG ]] ; then

    AUTOTMPDIR=/tmp/tmp_im
    trap 'set +x' EXIT

    #set -x
    $(mkdir "$AUTOTMPDIR") && true || $( rm -rfv -- "$AUTOTMPDIR"/* )
    #set +x

    #forcifully overwrite
    #EXTRACT_OPTION=" -y "
    EXTRACT_OPTION=" "
else

    AUTOTMPDIR="$(mktemp -d)"
    #trap 'rm -rfv -- "$AUTOTMPDIR"' EXIT
    trap 'rm -rf -- "$AUTOTMPDIR"' EXIT

    EXTRACT_OPTION="  "
fi

main_func ()
{

    printf '\n=============================\n'
    printf 'Input file %s\n' "$INPUT_FILE="

    DURATION_FLOAT=$(  ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 "$INPUT_FILE" )

#echo DURATION_FLOAT "$DURATION_FLOAT"

if ! [[ $DURATION_FLOAT =~ ^[+-]?[0-9]+\.?[0-9]*$  ]]; then
    echo "Video duration fail. Exit."
    exit 2
fi

#round to int "%.0f" - round to zero floating digits 
#we need en_US since ffprobe get result with dot delimiter whereas russian delimiter is comma
DURATION_ROUNDED=$( env LC_ALL=en_US.utf8 printf "%.0f\n" "$DURATION_FLOAT" )

#echo DURATION_ROUNDED "$DURATION_ROUNDED"

#set -x
ITEMS=$((( ROWS * COLUMNS )))
TIME_STEP=$(((  DURATION_ROUNDED / ITEMS )))
#set +x

for index in $(seq 1 $ITEMS) ; do

    PROGRESS_BAR_LENGTH=25
    PROGRESS_BAR_FLOAT=$(awk "BEGIN {print $index/$ITEMS*$PROGRESS_BAR_LENGTH}")

    PROGRESS_BAR=$( env LC_ALL=en_US.utf8 printf "%.0f\n" $(awk "BEGIN {print $index/$ITEMS*$PROGRESS_BAR_LENGTH}" ) )

    EMPTY_BAR=$((( PROGRESS_BAR_LENGTH - PROGRESS_BAR )))

    #set -x
    PROGRESS_PERCENTAGE=$((( (index*100) / ITEMS )))

    PROGRESS_LINE=$( printf -- '#%.0s' $(seq  1 "$PROGRESS_BAR" )  )
    EMPTY_LINE=$( printf -- ' %.0s' $(seq  1 "$EMPTY_BAR" )  )

    #echo -ne '#####                     (33%)\r'

    echo -ne '          Progress - '"$PROGRESS_LINE""$EMPTY_LINE"'  ('"$PROGRESS_PERCENTAGE"'%)\r'
    sleep 1

    # printf 'Index - %d of %d \n' "$index" "$ITEMS"
    # echo '          Progress - '"$PROGRESS_LINE""$EMPTY_LINE"'('"$PROGRESS_PERCENTAGE"'%)'

    # set +x

    # echo -ne '#####                     (33%)\r'
    # sleep 1
    # echo -ne '#############             (66%)\r'
    # sleep 1
    # echo -ne '#######################   (100%)\r'
    # echo -ne '\n'

    OFFSET=$((( index * TIME_STEP )))
    SUFFIX=$(printf "%05d" "$OFFSET"  )
    #echo SUFFIX "$SUFFIX"

    EXTRACTED_BASENAME="$AUTOTMPDIR"/output_"$SUFFIX"
    EXTRACTED_FILENAME="$EXTRACTED_BASENAME".extracted.png

    # -n dont overwrite
    # -y force overwrite
    #ffmpeg -n -ss "$i" -i "$INPUT_FILE" -vframes 1 "$AUTOTMPDIR"/output_"$i".png

    #ffmpeg "$EXTRACT_OPTION" -hide_banner -loglevel error  -ss "${TIME_POINTS[index]}" -i "$INPUT_FILE" -vframes 1 "$EXTRACTED_FILENAME"
    #printf '========================================================\n'
    #set -x
    ffmpeg -y -hide_banner -loglevel error  -ss "$OFFSET" -i "$INPUT_FILE" -vframes 1 "$EXTRACTED_FILENAME"
    #set +x

    #printf "identify begin\n"
    #identify "$EXTRACTED_FILENAME"
    #printf "identify end\n"


    RESIZED_FILENAME="$EXTRACTED_BASENAME".resized.png
    #printf '========================================================\n'
    #set -x
    convert  -resize 20% "$EXTRACTED_FILENAME" "$RESIZED_FILENAME"
    #set +x

    #printf "identify begin\n"
    #identify "$RESIZED_FILENAME"
    #printf "identify end\n"

    #TIMETEXT=$(date -d@"${TIME_POINTS[index]}" -u +%H:%M:%S)'  '"$INPUT_FILE"
    TIMETEXT=$(date -d@"$OFFSET" -u +%H:%M:%S)

    ANNOTATED_FILENAME="$EXTRACTED_BASENAME"_ANNOTATED.png

    #printf '========================================================\n'
    convert "$RESIZED_FILENAME" -family 'Roboto Condensed' -font 'Roboto-Condensed-Bold' -undercolor Black -pointsize 9 -fill white  -gravity NorthEast -annotate 0 "$TIMETEXT"  "$ANNOTATED_FILENAME"

done

#NEED FOR PROGRESS BAR
echo -ne '\n'

RESIZED_FILENAME_DIMENSIONS=$(identify "$RESIZED_FILENAME" | sed -re 's|^.*PNG ([0-9]+x[0-9]+).*|\1|')
#echo RESIZED_FILENAME_DIMENSIONS "$RESIZED_FILENAME_DIMENSIONS"

ATOM_WIDTH=$( echo "$RESIZED_FILENAME_DIMENSIONS" | sed 's|x| |' | awk '{print $1}')
ATOM_HEIGHT=$( echo "$RESIZED_FILENAME_DIMENSIONS" | sed 's|x| |' | awk '{print $2}')

#set -x
#printf 'width %i height %i \n' "$ATOM_WIDTH" "$ATOM_HEIGHT"
#set +x

#for mark_index in "${!MARK_KINDS[@]}"; do
#    #echo "$mark_index" _  "${MARK_KINDS[$mark_index]}"

#    ROW_NAME="$AUTOTMPDIR"/output_"${MARK_KINDS[mark_index]}".png
#    convert "$AUTOTMPDIR"/output_"${MARK_KINDS[mark_index]}"*_ANNOTATED.png  +append "$ROW_NAME"

#    printf "identify begin\n"
#    identify "$ROW_NAME"
#    printf "identify end\n"
#done

# convert "$AUTOTMPDIR"/output_L{1,2,3,4}.png -append "$AUTOTMPDIR"/output_appended.png

# set -x
# RESULT_WIDTH=$((( ATOM_WIDTH * 4)))
# RESULT_HEIGHT=$((( ATOM_HEIGHT  * 4)))
# convert "$AUTOTMPDIR"/output_appended.png -resize "$RESULT_WIDTH"x"$RESULT_HEIGHT" -quality 90 "$AUTOTMPDIR"/output_tmp.png
# set +x


#montage -background none -geometry +0+0 -tile 4x4 "$AUTOTMPDIR"/output_L*_ANNOTATED.png "$AUTOTMPDIR"/output_tmp.png
#montage -gravity North -border 100x0 -bordercolor LimeGreen  -background none -geometry +5+5 -tile 4x4 "$AUTOTMPDIR"/output_L*_ANNOTATED.png "$AUTOTMPDIR"/output_tmp.png

#set -x
montage -background none -geometry +1+1 -tile "$COLUMNS"x"$ROWS" "$AUTOTMPDIR"/output_*ANNOTATED.png "$AUTOTMPDIR"/output_tmp.png
#set +x

# printf "identify begin\n"
# identify "$AUTOTMPDIR"/output_tmp.png
# printf "identify end\n"

RESULT="$INPUT_FILE".output.png
#convert "$AUTOTMPDIR"/output_tmp.png -undercolor Black -pointsize 7 -fill white  -gravity SouthEast -annotate 0 $(basename -- "$INPUT_FILE") "$RESULT"
convert "$AUTOTMPDIR"/output_tmp.png -undercolor Black -pointsize 7 -fill white  -gravity Center -annotate 0 $(basename -- "$INPUT_FILE") "$RESULT"

# printf "identify begin\n"
# identify "$RESULT"
# printf "identify end\n"



#TEMPFILE="$AUTOTMPDIR"/tmp_mkvtool.txt

#exit 0
rm -rf -- "$AUTOTMPDIR"/*


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

#convert --list font

}


if [[ -n $1 ]]; then
    INPUT_FILE="$1"

    if ! [[ -f "$INPUT_FILE" ]] ; then
        echo File "$INPUT_FILE" does not exist.
    fi

    main_func

else
    echo There is no input file in command line.
fi


# echo "Checking input files in pipeline..."
# if [ -p /dev/stdin ]; then
#         echo "Data was piped to this script!"
#         # If we want to read the input line by line
#         while IFS= read line; do
#                 printf '\n\n\nLine: %s \n' ${line}

#                 INPUT_FILE=${line}
#                 if ! [[ -f "$INPUT_FILE" ]] ; then
#                     echo File "$INPUT_FILE" does not exist.
#                 else
#                     main_func
#                 fi

#         done
#         # Or if we want to simply grab all the data, we can simply use cat instead
#         # cat
#     else

#         echo "No input in pipe!."
# fi

echo "Exiting..."

exit 0

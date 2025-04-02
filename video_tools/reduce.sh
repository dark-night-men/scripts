#!/usr/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi


INPUT_FILE="$1"
CRF_VALUE="${3-28}"

OUTPUT_FILE="${INPUT_FILE%.*}".CRF_"$CRF_VALUE".${INPUT_FILE##*.}

FFMPEG_COMMAND=ffmpeg
# FFMPEG_COMMAND=/mnt/c/Users/serge/AppData/Local/Microsoft/WinGet/Links/ffmpeg.exe

# ffmpeg -i input.mp4 -vcodec libx265 -crf 28 output.mp4
# printf "ffmpeg -i %s -vcodec libx265 -crf %g %s" "$INPUT_FILE" "$CRF_VALUE" "$OUTPUT_FILE"

# env LC_ALL=en_US.utf8 time --format='%E' \
#     ffmpeg -y -threads 8 -i "$INPUT_FILE" -v warning  -hide_banner -stats -vcodec libx265 -crf "$CRF_VALUE" -x265-params log-level=warning \
#     "$OUTPUT_FILE"

# -hide_banner -stats

# ffmpeg -i input.ext -v warning -c:v hevc -x265-params log-level=warning output.ext
# ffmpeg -v warning -progress /dev/stdout -i in.mp4

$FFMPEG_COMMAND -threads 8 -i "$INPUT_FILE" -v warning -vcodec libx265 -crf "$CRF_VALUE" "$OUTPUT_FILE"


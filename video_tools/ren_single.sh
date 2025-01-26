#!/bin/bash

#TODO working with mkv and mp4 and others
#TODO warning for multiple avi files

AVI_NAME=$(ls -1 *.avi | head -n1 | sed -re "s|^(.*)\.avi$|\1|")

AUDIO_FILE=$(ls -1 *.*.ac3 | head -n1)
PREFIX_TOBE_RENAMED="${AUDIO_FILE%.*.ac3}"

rename -v "s/$PREFIX_TOBE_RENAMED/$AVI_NAME/" *.ac3 *.srt

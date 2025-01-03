#!/bin/bash

# Fallout.S01E01.WEB-DLRip.RGzsRutracker.avi
PREFIX=Fallout.S01E0
SUFFIX=.WEB-DLRip.RGzsRutracker

 for x in $(seq 1 8) ; do
    rm -v /tmp/ext_avi.log

    #extract two audio tracks simultaneously
    ffmpeg -y -i ${PREFIX}${x}${SUFFIX}.avi -map 0:a:0 ${PREFIX}${x}${SUFFIX}.ru.mp3  -map 0:a:1 ${PREFIX}${x}${SUFFIX}.en.mp3 |& tee  -a /tmp/ext_avi.log

 done

#!/bin/bash

 for x in $(seq 1 8) ; do
    #mplayer -dumpaudio -dumpfile Inside.Job.S02E0${x}.WEBRip.NewStation.mp3 Inside.Job.S02E0${x}.WEBRip.NewStation.avi |& tee /tmp/ext_avi.log

    #get info about available streams (audio and video)
    #ffmpeg -i file.avi

    #get ONLY info about available streams (audio and video)
    #ffprobe -v error -show_entries stream=index,codec_name,codec_type Inside.Job.S02E01.WEBRip.NewStation.avi 

    #-map 0:1 - set audio stream for output explisitly
    #ffmpeg -y -i Inside.Job.S02E0${x}.WEBRip.NewStation.avi -map 0:1  Inside.Job.S02E0${x}.WEBRip.NewStation.mp3 |& tee /tmp/ext_avi.log

    #extract 'default' audio track
    #ffmpeg -y -i Inside.Job.S02E0${x}.WEBRip.NewStation.avi  Inside.Job.S02E0${x}.WEBRip.NewStation.mp3 |& tee /tmp/ext_avi.log

    rm -v /tmp/ext_avi.log

    #extract two audio tracks simultaneously
    ffmpeg -y -i Inside.Job.S02E0${x}.WEBRip.NewStation.avi -map 0:a:0 Inside.Job.S02E0${x}.WEBRip.NewStation.ru.mp3  -map 0:a:1 Inside.Job.S02E0${x}.WEBRip.NewStation.en.mp3 |& tee  -a /tmp/ext_avi.log

 done

#!/bin/bash


 # ffmpeg -i v.mp4 -i a.wav -c:v copy -map 0:v:0 -map 1:a:0 new.mp4
 ffmpeg \
     -i ./Auntie.Lee\'s.Meat.Pies.1992.Vinegar.Syndrome.BDRemux.1080p.mp4 \
     -i ./Auntie.Lee\'s.Meat.Pies.1992.Vinegar.Syndrome.BDRemux.1080p.2.mp3 \
     -c copy \
     -map 0:0 -map 0:1 -map 1:0 \
     ./Auntie.Lee\'s.Meat.Pies.1992.Vinegar.Syndrome.BDRemux.1080p.mkv


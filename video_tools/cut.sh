#!/bin/bash

# env LC_ALL=en_US.utf8 time --format='%E'   ffmpeg -y -fflags +genpts -ss 21:10 -i two.and.a.half.men.s02e09.web-dlrip.avi -ss 0:00 -t 22  -c:v libx264 -crf 18  p4.avi

env LC_ALL=en_US.utf8 time --format='%E' ffmpeg -y -fflags +genpts -ss 4:34 -i /mnt/c/Users/serge/Videos/!heap/Upstart.Crow.S03E02.1080p.HDTVRip.Rus.Eng.Ozz_New.avi -ss 0:00 -t 4:30  -c:v libx264 -crf 18  hamlet.avi


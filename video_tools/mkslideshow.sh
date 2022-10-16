#!/bin/bash

find -type f \( -iname '*.jpg'  \) -print | sort | sed -re "s/'/\'\\\'\'/g"  -e "s|^|file '|" -e "s|$|'\nduration 5\n|"   > jpg.txt
find -type f \( -iname '*.png'  \) -print | sort | sed -re "s/'/\'\\\'\'/g"  -e "s|^|file '|" -e "s|$|'\nduration 5\n|"   > png.txt
find -type f \( -iname '*.gif'  \) -print | sort | sed -re "s/'/\'\\\'\'/g"  -e "s|^|file '|" -e "s|$|'\nduration 5\n|"   > gif.txt

#LINE=$(tail -n3 input.txt|head -n1)
#echo "$LINE" >> input.txt

#env LC_ALL=en_US.utf8 time --format='\n elapsed time  %E \n' ffmpeg -hide_banner -loglevel error -f concat -safe 0 -i input.txt -vsync vfr -pix_fmt yuvj422p  -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2"   output.mp4

#report
#env LC_ALL=en_US.utf8 time --format='\n elapsed time  %E \n' ffmpeg -hide_banner -loglevel error -report -f concat -safe 0 -i input.txt -vsync vfr -pix_fmt yuvj422p  -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2"   output.mp4

#aspect
##set -x
##find -maxdepth 1 \( -name jpg.txt -o -name png.txt -o -name gif.txt \)  | while read -r; do $( echo "$REPLY";


env LC_ALL=en_US.utf8 time --format='\n elapsed time  %E \n' ffmpeg -y -hide_banner \
    -loglevel error \
    -f concat -safe 0 -i jpg.txt -vsync vfr\
    -vf 'scale=3440:1440:force_original_aspect_ratio=decrease,pad=3440:1440:(ow-iw)/2:(oh-ih)/2,setsar=1' \
    -c:v libx264 -crf 14 -r 25 -pix_fmt yuvj422p -shortest  jpg.output.mp4 ;

env LC_ALL=en_US.utf8 time --format='\n elapsed time  %E \n' ffmpeg -y -hide_banner \
    -loglevel error \
    -f concat -safe 0 -i png.txt -vsync vfr\
    -vf 'scale=3440:1440:force_original_aspect_ratio=decrease,pad=3440:1440:(ow-iw)/2:(oh-ih)/2,setsar=1' \
    -c:v libx264 -crf 14 -r 25 -pix_fmt yuvj422p -shortest  png.output.mp4 ;

env LC_ALL=en_US.utf8 time --format='\n elapsed time  %E \n' ffmpeg -y -hide_banner \
    -loglevel error \
    -f concat -safe 0 -i gif.txt -vsync vfr\
    -vf 'scale=3440:1440:force_original_aspect_ratio=decrease,pad=3440:1440:(ow-iw)/2:(oh-ih)/2,setsar=1' \
    -c:v libx264 -crf 14 -r 25 -pix_fmt yuvj422p -shortest  gif.output.mp4 ;

#)
#
#done
#set +x

#long long
#keyframes
#env LC_ALL=en_US.utf8 time --format='\n elapsed time  %E \n' ffmpeg -hide_banner -loglevel error\
#    -f concat -safe 0 -i input.txt -vsync cfr\
#    -vf 'scale=3440:1440:force_original_aspect_ratio=decrease,pad=3440:1440:(ow-iw)/2:(oh-ih)/2,setsar=1' \
#    -c:v libx264 -x264-params keyint=50:scenecut=0 -crf 14 -r 25 -pix_fmt yuvj422p -shortest  output.mp4

#ffmpeg -i <input> -vcodec libx264 -x264-params keyint=120:scenecut=0 -acodec copy out.mp4


#ffmpeg -framerate 1/10 -i img%3d.png -i audio.wav \
#    -vf 'scale=3840:2880:force_original_aspect_ratio=decrease,pad=3840:2880:(ow-iw)/2:(oh-ih)/2,setsar=1' \
#    -c:v libx264 -crf 14 -r 25 -pix_fmt yuv420p -shortest output.mp4


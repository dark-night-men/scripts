#!/bin/bash

export LC_ALL=en_US.utf8

echo Hello World

if ! [[ -n $1 ]] ; then
    echo File must be specified.
fi


FILEFULLNAME=$1


VERPATH=/c/Users/agibalov/Videos/TOOLS/mkvtoolnix-64-bit-46.0.0
TOOLPATH=$VERPATH/mkvtoolnix

export IFS=$'\n'

#for x in $( ls -1 $DIRPATH ) ; do
#
#    echo $x
#    #file $x
#
#    $TOOLPATH/mkvextract.exe tracks $x 3:$DIRPATH/${x%.*}.srt
#done


#extract subs
#$TOOLPATH/mkvextract.exe tracks $FILEFULLNAME 2:${FILEFULLNAME%.*}.eng.srt

#$TOOLPATH/mkvinfo.exe $FILEFULLNAME 
mkvinfo $FILEFULLNAME 

exit

  #./mkvextract.exe tracks ~/Videos/TVShows/Avenue.5.S01.1080p.TVShows/Avenue.5.S01E02.1080p.TVShows.mkv 3:sub.srt | less


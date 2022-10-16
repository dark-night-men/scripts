#!/usr/bin/bash

echo Hello World

if ! [[ -n $1 ]] ; then
    echo File must be specified.
fi


FILEFULLNAME=$1


VERPATH=/c/Users/agibalov/Videos/TOOLS/mkvtoolnix-64-bit-53.0.0
TOOLPATH=$VERPATH/mkvtoolnix

export IFS=$'\n'

#for x in $( ls -1 $DIRPATH ) ; do
#
#    echo $x
#    #file $x
#
#    $TOOLPATH/mkvextract.exe tracks $x 3:$DIRPATH/${x%.*}.srt
#done

#extract audio
$TOOLPATH/mkvextract.exe tracks $FILEFULLNAME 1:${FILEFULLNAME%.*}.ac3

#extract subs
$TOOLPATH/mkvextract.exe tracks $FILEFULLNAME 2:${FILEFULLNAME%.*}.eng.srt
exit

  #./mkvextract.exe tracks ~/Videos/TVShows/Avenue.5.S01.1080p.TVShows/Avenue.5.S01E02.1080p.TVShows.mkv 3:sub.srt | less

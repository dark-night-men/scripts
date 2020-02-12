#!/bin/bash

LOGDIR=/home/zerg/export/log
LSALL=$LOGDIR/lsall.log
DUPS=$LOGDIR/dups.log

find /home/zerg/export/DiskStation/video*/{movies_proxy*/{[Mm]ovies,queue,new},movies} \
   \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \
   \( \
    -type f \
    -iname '*.avi' -o -iname '*.mkv' -o -iname '*.mp4' \
    \) -print \
    > $LSALL

sed 's/^.*\///' $LSALL | sort | uniq -c | egrep -v '[[:space:]]+1' > $DUPS

#!/bin/bash

if ((BASH_VERSINFO[0] < 4)); then
    echo "Bash must be at least of version 4. Exiting." >&2
    exit 1;
fi

for disk in d e f; do

    env LC_ALL=en_US.utf8 time --format='%E' \
    ~/scripts/video_tools/list_huge_new.sh /mnt/$disk/\!${disk^^}_VIDEO  > ~/tmp/${disk}_huge.log

    SKIPPED_FILES_FOR_DISK=/tmp/${disk}_skipped_files.txt
    [ -f $SKIPPED_FILES_FOR_DISK ] && rm -v "$SKIPPED_FILES_FOR_DISK"

    COMMON_SKIPPED_FILES=/tmp/skipped_files.txt
    [ -f $COMMON_SKIPPED_FILES ] && mv -v "$COMMON_SKIPPED_FILES"  "$SKIPPED_FILES_FOR_DISK"

    sort -k1,1 -h -r ~/tmp/${disk}_huge.log > ~/tmp/${disk}_1huge.log 

done

vim ~/tmp/*huge.log /tmp/*skipped_files.txt 

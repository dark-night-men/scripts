#!/bin/bash

if ((BASH_VERSINFO[0] < 4)); then
    echo "Bash must be at least of version 4. Exiting." >&2
    exit 1;
fi

for disk in d e f; do

    env LC_ALL=en_US.utf8 time --format='%E' \
    ~/scripts/video_tools/list_huge_new.sh /mnt/$disk/\!${disk^^}_VIDEO  > ~/tmp/${disk}_huge.log

    cp -v /tmp/skipped_files.txt /tmp/${disk}_skipped_files.txt
    sort -k1,1 -h -r ~/tmp/${disk}_huge.log > ~/tmp/${disk}_1huge.log 

done

vim ~/tmp/*huge.log /tmp/*skipped_files.txt 

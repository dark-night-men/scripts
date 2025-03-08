#!/bin/bash

if ((BASH_VERSINFO[0] < 4)); then
    echo "Bash must be at least of version 4. Exiting." >&2
    exit 1;
fi

ALL_SKIPPED_FILES=/tmp/all_skipped_files.txt
[ -f $ALL_SKIPPED_FILES ] && rm -v "$ALL_SKIPPED_FILES"

ALL_HUGE_FILES=/tmp/all_huge_files.txt
[ -f $ALL_HUGE_FILES ] && rm -v "$ALL_HUGE_FILES"

ALL_1HUGE_FILES=/tmp/all_1huge_files.txt
[ -f $ALL_1HUGE_FILES ] && rm -v "$ALL_1HUGE_FILES"

for disk in d e f; do

    env LC_ALL=en_US.utf8 time --format='%E' \
    ~/scripts/video_tools/list_huge_new.sh /mnt/$disk/\!${disk^^}_VIDEO  > ~/tmp/${disk}_huge.log

    SKIPPED_FILES_FOR_DISK=/tmp/${disk}_skipped_files.txt
    [ -f $SKIPPED_FILES_FOR_DISK ] && rm -v "$SKIPPED_FILES_FOR_DISK"

    COMMON_SKIPPED_FILES=/tmp/skipped_files.txt
    [ -f $COMMON_SKIPPED_FILES ] && mv -v "$COMMON_SKIPPED_FILES"  "$SKIPPED_FILES_FOR_DISK" && cat "$SKIPPED_FILES_FOR_DISK" >> "$ALL_SKIPPED_FILES"


    sort -k1,1 -h -r ~/tmp/${disk}_huge.log > ~/tmp/${disk}_1huge.log 

    cat ~/tmp/${disk}_huge.log >> "$ALL_HUGE_FILES"
    cat ~/tmp/${disk}_1huge.log >> "$ALL_1HUGE_FILES"

done

[ -f $ALL_HUGE_FILES ] && sort -k2,2 -h -r -o "${ALL_HUGE_FILES}"{,}
[ -f $ALL_1HUGE_FILES ] && sort -k1,1 -h -r -o "${ALL_1HUGE_FILES}"{,}

vim "$ALL_HUGE_FILES" "$ALL_1HUGE_FILES" ~/tmp/*huge.log /tmp/*skipped_files.txt 

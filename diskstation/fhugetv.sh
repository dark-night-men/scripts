find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) \
    -prune -o \( \
        -ipath "*/*series*/*" -type f -size +512M \
        -exec bash -c \
        'IFS=$(echo -en "\n\b");
        ls -lh $0 | awk '\''{print $5}'\'' ' {}  \; \
    \) -print


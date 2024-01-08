#!/bin/bash

while IFS=  read -r -d $'\0'; do

    # echo "$REPLY"
    file_name=$(echo "$REPLY" | sed -re 's|^\./||')


    # printf '%s\n' $file_name
    # grep -w "$file_name" ./toc.ncx
    # toc_line=$(grep -w "$file_name" ./toc.ncx)
    label_text=$(grep -w "$file_name" ./toc.ncx | sed -re 's|^.*<text>(.+)</text>.*$|\1|')

    sed -i "s|>$file_name<|>$label_text<|" ./index.html

    # echo $toc_line

done < <(find -type f -iname '*.xhtml' -print0)

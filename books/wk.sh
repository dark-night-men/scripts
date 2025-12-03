#!/bin/bash

if ! [[ -f "$1" ]] ; then
    echo File "$1" does not exist. exit.
    exit 1
fi

if [[ -z $2 ]]; then
    echo Second arg must be provided, as title.
    exit 2
fi

if [[ -z $3 ]]; then
    echo Third arg must be provided, as author\'s name.
    exit 3
fi

echo "arg 1 $1"

cmd=(
/usr/bin/ebook-convert "$1" "$1.epub" 
    --pretty-print
    --enable-heuristics
    --verbose
    --change-justification left
    --title="$2" --authors="$3"
    --embed-font-family  'Comfortaa'
    # --extra-css "body { line-height: $LINE_HEIGHT !important; }"
    # --extra-css ${4-""}
    # --minimum-line-height ${5-555} 
    # --minimum-line-height ${5-70} 
    --minimum-line-height 70 
    # --minimum-line-height ${5-22} 
    # --minimum-line-height 0
    # --line-height 1
    # --filter-css 'line-height'
    # --filter-css 'font-family,line-height'
)

echo "Executing: "
printf "%q " "${cmd[@]}"
echo

"${cmd[@]}" 

#/usr/local/bin/wkhtmltopdf "$1" "$1.pdf"

#regular flow

#/usr/bin/ebook-convert "$1" .epub --pretty-print --enable-heuristics --embed-font-family  'Monofur NF' --no-default-epub-cover --epub-flatten --verbose -d debug

#merging flow
#export LC_ALL=en_US.utf8
#env LC_ALL=en_US.utf8 /usr/bin/ebook-convert  "$1" "$1.epub" --pretty-print --enable-heuristics --embed-font-family  'Monofur NF' --verbose -d debug

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

LINE_HEIGHT=${5-0.5em}
NAME_SUFFIX=$(echo $LINE_HEIGHT | sed -re 's|\.||')

#/usr/bin/ebook-convert "$1" "$1_clm.mobi" --pretty-print --enable-heuristics --filter-css font-family,color,margin-left,margin-right
#/usr/bin/ebook-convert "$1" "$1_clm.mobi" --pretty-print --enable-heuristics
# /usr/bin/ebook-convert "$1" "${6-$1}_ccf_${NAME_SUFFIX}.mobi"\
#     --mobi-file-type new\
#     # --pretty-print\
#     # --enable-heuristics\
#     --verbose\
#     --change-justification left\
#     --title="$2" --authors="$3"\
#     --embed-font-family  'Comfortaa'\
#     # --extra-css "body { line-height: $LINE_HEIGHT !important; }"\
#     --extra-css ${4-""}\
#     --minimum-line-height ${5-70} \
#     --line-height 11\
#     --filter-css 'line-height'

cmd=(
/usr/bin/ebook-convert "$1" "${6-$1}_ccf_${NAME_SUFFIX}.mobi"
    --mobi-file-type new
    # --pretty-print
    # --enable-heuristics
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


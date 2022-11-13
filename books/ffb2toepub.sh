#!/bin/bash

#/usr/bin/ebook-convert "$1" "$1.epub" --pretty-print --enable-heuristics 

IFS=$(echo -en "\n\b");

find \
    $PWD \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) \
    -prune -o \( \
        -iname "*.fb2" -type f \
        -exec bash -c \
        'IFS=$(echo -en "\n\b");
        #echo "TESTFILE 0 $0";

        #echo FB2 striped ${0%.fb2} 

        EPUB_FILE=${0%.fb2}.epub
        EPUB_CLB_FILE=${0%.fb2}_clb.epub
        #[[ -f $EPUB_FILE ]] && echo EPUB YES $EPUB_FILE
        ! [[ -f $EPUB_FILE ]] && ! [[ -f $EPUB_CLB_FILE ]] && /usr/bin/ebook-convert "$0" "$EPUB_CLB_FILE" --pretty-print --enable-heuristics 

        MOBI_FILE=${0%.fb2}.mobi
        MOBI_CLB_FILE=${0%.fb2}_clb.mobi
        #[[ -f $MOBI_FILE ]] && echo MOBI YES $MOBI_FILE
        ! [[ -f $MOBI_FILE ]] && ! [[ -f $MOBI_CLB_FILE ]] && /usr/bin/ebook-convert "$0" "$MOBI_CLB_FILE" --pretty-print --enable-heuristics 

        #echo ..................................

        ' {} \; \
    \)

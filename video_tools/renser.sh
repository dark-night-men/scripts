#!/bin/bash

PREFIX=Rick.and.Morty.S07E

for x in {01..8}; do
    # set -x

    PREFIX_1=$PREFIX$x.


    NAME=$(ls -1 $PREFIX_1*.avi | sed -re "s|^($PREFIX_1.*)\.avi$|\1|")
    # printf 'NAME %s \n\n' $NAME

    AC3NAME=$(ls -1 $PREFIX_1*1.ac3 | sed -re "s|^($PREFIX_1.*)\.1\.ac3$|\1|")

    # rename -n -v "s/$AC3NAME/$NAME/" *.ac3 *.srt
    rename -v "s/$AC3NAME/$NAME/" *.ac3 *.srt


# set +x

done

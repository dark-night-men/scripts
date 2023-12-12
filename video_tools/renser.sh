#!/bin/bash

PREFIX=Rick.and.Morty.S07E01.

# set -x


NAME=$(ls -1 $PREFIX*.avi | sed -re "s|^$PREFIX(.*)\.avi$|\1|")
# printf 'NAME %s \n\n' $NAME

AC3NAME=$(ls -1 $PREFIX*1.ac3 | sed -re "s|^$PREFIX(.*)\.1\.ac3$|\1|")

# rename -n -v "s/$AC3NAME/$NAME/" *.ac3 *.srt
rename -v "s/$AC3NAME/$NAME/" *.ac3 *.srt


# set +x

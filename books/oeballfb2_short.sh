#!/bin/bash

 find -type f -iname '*.fb2' \
     -exec sh -c  'set -x; DIRNAME=$(echo "$0"|sed -re "s|^\./Пушкин\ А.С.\ \-\ (.*)\.fb2$|\1|" );  /home/zerg/tmp/tmpscripts/oeb.sh "$0" html/"$DIRNAME"; set +x; ' {} \; |& tee /tmp/log

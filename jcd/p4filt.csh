#!/bin/bash

wsps=`echo "$P4DIR/pvs"`

while read line
do
    ##echo "$line"
    ##echo "$line" | grep '^t'

##    echo "$line" | sed 's|^==== .*\/pvs\/\(.*\) ====|--- \1|'

    #this does not work with pvs_QuickTest
    #filepath=`echo "$line" | sed 's|^.*\(/src/.*/src/.*\)#.*|\1|'`
    #echo "$wsps$filepath"

    fpath=`echo "$line" | sed 's|#.*$||'`
    ##echo "$fpath"
    
    p4 where "$fpath" | cut -d ' ' -f3


done < "${1:-/proc/${$}/fd/0}"



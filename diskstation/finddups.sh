#!/bin/bash

#echo "Hello world"
#SAVEIFS=$IFS
#IFS=$(echo -en "\n\b")
#IFS=$'\n'

dCounter=0

while read p; do
    #echo "$p"
    #i=awk '{print $1}' "$p"
    i=`echo "$p" | awk '{print $1}'`

    #echo "$i"
    if [[ $i == $k ]] ; then
        ((dCounter++))
        if [[ $dCounter -eq 1 ]] ;then
            #echo $kValue | awk '{print $2}'
            echo $kValue 
        fi
        #echo $p | awk '{print $2}'
        echo $p 
    else
        if [[ $dCounter -ne 0 ]] ;then
            echo \.
        fi
        dCounter=0
    fi

    k=$i
    kValue=$p


done < "$1"
#done < <(head "$1")

#for p in `head -n1 "$1"`; do
#    #echo "$p"
#    #i=`awk '{print $1}' "$p"`
#    echo "$p" | awk '{print $1}'
#
#    echo "$i"
#
#done

#head /tmp/flss  | awk '{print $1}'


#IFS=$SAVEIFS


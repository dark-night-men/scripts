#!/bin/bash

printf "%s" $( echo "$1"| translit -r  -t 'GOST 7.79 RUS' ) 
#printf "%s" | translit -r  -t 'GOST 7.79 RUS' 

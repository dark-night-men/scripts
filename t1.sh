#!/bin/bash

c=0

{
    while read ff; do
    let c+=1

    echo $c $ff
    done 
}</tmp/tx

#!/bin/bash
sed -l 0 ':r;$!{N;br};s/\n\([[:lower:] ]\)/ \1/g' "$1"

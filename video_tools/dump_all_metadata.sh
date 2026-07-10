#!/usr/bin/bash

find -type f -regextype egrep -iregex '^.*\.(avi|mkv|mp4|mpg|flv|wmv|ts)$' -exec ~/scripts/video_tools/dump_metadata.sh {} \; -print

#!/bin/bash
  ( cat /tmp/movie_list.txt | while read line; do echo "$line"; findxm "$line" ; done ) |& tee /tmp/log

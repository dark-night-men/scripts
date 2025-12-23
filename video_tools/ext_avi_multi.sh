#!/bin/bash


# FFPROBE_AUDIO_STREAMS=/tmp/ffprobe_audio_streams.log

rm -v /tmp/ffprobe_audio_streams.log

find -type f -regextype egrep -iregex '^.*\.(mkv|avi|mp4|wmv|mpg|ts)$' -print0 | xargs -0  bash -c \
     ' 
      for arg do

          printf "\n\n****************************************************************\n\n";
          ls -1 "$arg";

          ffprobe -v error -show_entries stream=index,codec_name,codec_type "$arg" > /tmp/ffprobe_audio_streams.log;

          audio_number=$( grep audio /tmp/ffprobe_audio_streams.log | wc -l);
          # printf "audio_number %s \n" $audio_number;

          for kind in mp3 ac3 aac; do

              audio_kind=$( grep -o -m 1 $kind /tmp/ffprobe_audio_streams.log);

              if ! [[ -z $audio_kind ]]; then
                  break
              fi
          done

          # printf "audio_kind %s \n" $audio_kind;

          if [[ -z $audio_kind  ]]; then

              echo "Can not detect audio kind. Exit."
              exit 1;
          fi


          # set -x

          stripped_arg_path="${arg%.*}"
          # printf "stripped_arg_path %s \n" $stripped_arg_path;

          # tmp_arg_path=$(/usr/bin/printf '%q' "$stripped_arg_path")
          stripped_arg_path=$(printf '%q' "$stripped_arg_path")

          # printf "stripped_arg_path %s \n" $stripped_arg_path;

          # set +x


          # set -x

          # printf "before escaped arg\n"

          # escaped_arg=$(/usr/bin/printf '%q' "$arg")
          escaped_arg=$(printf '%q' "$arg")

          # ffmpeg_command="ffmpeg -hide_banner -loglevel error  -y -i $escaped_arg" 
          ffmpeg_command="ffmpeg -y -i $escaped_arg" 

          # printf "after escaped arg\n"

          # eval "$ffmpeg_command"
          # set +x
          
          audio_number_zero=$((( $audio_number - 1 )));
          # for x in $(seq -f "%02g"  0 +1 $audio_number_zero); do

          launch_flag=""
          for x in $(seq -f "%g"  0 +1 $audio_number_zero); do

              # printf "index %s\n"  $x ; 


              case $x in

                  0 | 00)
                      # set -x
                      ru_output="${stripped_arg_path}.ru.${audio_kind}"

                      # ls -lh "$ru_output"
                      # ls -lh $ru_output

                      printf "%s\n" "$ru_output" 

                      # echo "$ru_output" | od -c
                      # echo "$ru_output" | xargs ls -lh

                      # printf "\nxargs echo ru_output\n"
                      # echo "$ru_output" | xargs 
                      # # tmp_var= $( echo "$ru_output" | xargs ) 
                      # tmp_var=echo "$ru_output" | xargs printf "%s\n"
                      # tmp_var=$( printf "%s\n" "$ru_output" )

                      # printf  "\nod  echo tmp_var\n"
                      # echo "$tmp_var" | od -c
                      
                      # if [[ -e "$tmp_var" ]]; then
                      #     echo $tmp_var exist tmp
                      # else
                      #     echo $tmp_var does not exist tmp
                      # fi

                     
                      # find -iname "$ru_output"

                      # if [[ -e "$ru_output" ]]; then
                      #     echo $ru_output exist. Continue.

                      #     # set +x
                      #     continue
                      # fi

                      echo "$ru_output" | xargs ls -lh

                      if [[ $? -eq 0  ]]; then

                          echo $ru_output exist. Continue.
                          continue
                      fi

                      launch_flag=true
                      ffmpeg_command="${ffmpeg_command} -map 0:a:0 $ru_output"
                      ;;

                  1 | 01)

                      # set -x
                      en_output="${stripped_arg_path}.en.${audio_kind}"

                      # if [[ -e "$en_output" ]]; then
                      #     echo $en_output exist. Continue.

                      #     # set +x
                      #     continue
                      # fi

                      echo "$en_output" | xargs ls -lh

                      if [[ $? -eq 0  ]]; then

                          echo $en_output exist. Continue.
                          continue
                      fi


                      launch_flag=true
                      ffmpeg_command="${ffmpeg_command} -map 0:a:1 $en_output"
                      ;;

                  *)

                      # set -x
                      index_output="${stripped_arg_path}.${x}.${audio_kind}"

                      # if [[ -e "$index_output" ]]; then
                      #     echo $index_output exist. Continue.

                      #     # set +x
                      #     continue
                      # fi

                      echo "$index_output" | xargs ls -lh

                      if [[ $? -eq 0  ]]; then

                          echo $index_output exist. Continue.
                          continue
                      fi


                      launch_flag=true
                      ffmpeg_command="${ffmpeg_command} -map 0:a:${x} $index_output"
                      ;;
              esac;

              # set +x

          done

          # set -x

          if [[ -n $launch_flag ]]; then

              printf "command : %s\n" $ffmpeg_command
              printf "Launching command \n" 

              eval "$ffmpeg_command"
          else
              printf "launch_flag is down\n"
          fi
          # set +x

          if ! [[ $? -eq 0  ]]; then

              echo ffmpeg finished with errors. Exit.
              exit 2
          fi

        done
        ' _ 

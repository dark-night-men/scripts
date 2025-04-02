#!/usr/bin/bash

 # mediainfo --Output=XML --Inform="Audio;%StreamKind% %ID% %Title% %Language/String3% %Default%\n" "$1" >> "$1".metadata_dump.txt

OUTPUT_FILE_NAME="$1".mediainfo_dump.txt
FULL_OUTPUT_FILE_NAME="$1".mediainfo_full_dump.txt

mediainfo "$1" > "$FULL_OUTPUT_FILE_NAME"

mediainfo --Inform="Audio;%ID% StreamKind %StreamKind%\n%ID% Title %Title%\n%ID% Language/String3 %Language/String3%\n%ID% Default %Default%\n" "$1" > "$OUTPUT_FILE_NAME"
mediainfo --Inform="Text;%ID% StreamKind %StreamKind%\n%ID% Title %Title%\n%ID% Language/String3 %Language/String3%\n%ID% Default %Default%\n" "$1" >> "$OUTPUT_FILE_NAME"
mediainfo --Inform="Video;%ID% StreamKind %StreamKind%\n%ID% Title %Title%\n%ID% Language/String3 %Language/String3%\n%ID% Default %Default%\n" "$1" >> "$OUTPUT_FILE_NAME"
 
sed -i '/^[[:blank:]]*$/ d' "$OUTPUT_FILE_NAME"
sort -h -o "${OUTPUT_FILE_NAME}"{,}

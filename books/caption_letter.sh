 7528  2022-06-19 03:56:07 sed -l 0 -re 's/(([0-9. [:upper:]])*[[:upper:]]{2,}[[:space:]]+([0-9][[:space:]]{0,}\w{0,}[[:space:]]{0,}[0-9]{0,})*)/\n###\1###\n/g' 19.B.md > 19.C.md
 7529  2022-06-19 03:56:09 fg
 7530  2022-06-19 03:56:37 sed -l 0 -re 's/(([0-9. [:upper:]])*[[:upper:]]{2,}[[:space:]]+([0-9][[:space:]]{0,}\w{0,}[[:space:]]{0,}[0-9]{0,}\.?)*)/\n###\1###\n/g' 19.B.md > 19.C.md
 7531  2022-06-19 03:56:39 fg
 7532  2022-06-19 03:58:03 sed -l 0 -re 's/(([0-9.[:space:][:upper:]])*[[:upper:]]{2,}[[:space:]]+([0-9][[:space:]]{0,}\w{0,}[[:space:]]{0,}[0-9]{0,}\.?)*)/\n###\1###\n/g' 19.B.md > 19.C.md
 7533  2022-06-19 03:58:05 fg
 7534  2022-06-19 03:59:37 sed -l 0 -re 's/([0-9]+\.([:space:][:upper:]])*[[:upper:]]{2,}[[:space:]]+([0-9][[:space:]]{0,}\w{0,}[[:space:]]{0,}[0-9]{0,}\.?)*)/\n###\1###\n/g' 19.B.md > 19.C.md
 7535  2022-06-19 04:00:18 sed -l 0 -re 's/([0-9]+\.([[:space:].[:upper:]])*[[:upper:]]{2,}[[:space:]]+([0-9][[:space:]]{0,}\w{0,}[[:space:]]{0,}[0-9]{0,}\.?)*)/\n###\1###\n/g' 19.B.md > 19.C.md
 7536  2022-06-19 04:00:27 fg
 7537  2022-06-19 04:03:02 h| tail > ~/tmp/tmpscripts/books/caption_letter.sh
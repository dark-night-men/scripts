 7542  2022-06-19 04:04:47 vim 19.C.md 
 7543  2022-06-19 04:06:52 sed -l 0 -re 's/\. +([0-9]+\t)/.\n\1/g' 19.C.md > 19.D.md
 7544  2022-06-19 04:06:55 fg
 7545  2022-06-19 04:08:12 sed -l 0 -re 's/\. +([0-9]+\t)/.\n\t\1/g' 19.C.md > 19.D.md
 7546  2022-06-19 04:08:19 less 19.D.md 
 7547  2022-06-19 04:10:06 sed -l 0 -re 's/\. +([0-9]+)\t/.\n\t\1 /g' 19.C.md > 19.D.md
 7548  2022-06-19 04:10:25 sed -l 0 -re 's/([0-9]+\.([[:space:].[:upper:]])*[[:upper:]]{2,}[[:space:]]+([0-9][[:space:]]{0,}\w{0,}[[:space:]]{0,}[0-9]{0,}\.?)*)/\n\n###\1###\n/g' 19.B.md > 19.C.md
 7549  2022-06-19 04:10:29 sed -l 0 -re 's/\. +([0-9]+)\t/.\n\t\1 /g' 19.C.md > 19.D.md
 7550  2022-06-19 04:10:30 fg
 7551  2022-06-19 04:11:59 h| tail > ~/tmp/tmpscripts/books/notes.sh

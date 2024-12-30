#!/bin/bash

 mkdir -v ./tmp

 # ffmpeg -i v.mp4 -i a.wav -c:v copy -map 0:v:0 -map 1:a:0 new.mp4
 ffmpeg \
     -i ./Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.mp4 \
     \
     -i ./Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.1.ru.ac3 \
     -i ./Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.2.ru.ac3 \
     -i ./Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.3.ru.ac3 \
     -i ./Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.4a.fr.ac3 \
     -i ./Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.6.ru.srt \
     -i ./Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.7.en.srt \
     \
     -c copy \
     -map 0:0 -map 1:0 -map 2:0 -map 3:0 -map 4:0 -map 5:0 -map 6:0 \
     \
     -metadata:s:a:0 language=rus -metadata:s:a:0 title="Paragraph Media" \
     -metadata:s:a:1 language=rus -metadata:s:a:1 title="LineFilm" \
     -metadata:s:a:2 language=rus -metadata:s:a:2 title="ViruseProject" \
     -metadata:s:a:3 language=fra -metadata:s:a:3 title="..." \
     \
     -metadata:s:s:0 language=rus -metadata:s:s:0 title="Русский (субтитры)" \
     -metadata:s:s:1 language=eng -metadata:s:s:1 title="Английский (субтитры)" \
     \
     ./tmp/Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.mkv

# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.1.ru.ac3
# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.2.ru.ac3
# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.3.ru.ac3
# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.4a.fr.ac3
# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.6.ru.srt
# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.7.en.srt
# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.9.ru.srt
# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.mp4
# Humanist.Vampire.Seeking.Consenting.Suicidal.Person.2023.BDRip.1080p.ExKinoRay.pbf

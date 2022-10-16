 ffmpeg -i Re-Animator\ \(DVDrip\,\ Rus\)_int_.avi -vn -acodec copy output-audio.mp3
 ffmpeg -i Re-Animator\ \(DVDrip\,\ Rus\)_int_.avi -map 0:a:1  -vn -acodec copy 1.mp3
 ffmpeg -i Re-Animator\ \(DVDrip\,\ Rus\)_int_.avi -map 0:a:0  -vn -acodec copy 0.mp3
 ffmpeg -i Re-Animator\ \(DVDrip\,\ Rus\)_int_.avi -map 0:a:2  -vn -acodec copy 2.mp3

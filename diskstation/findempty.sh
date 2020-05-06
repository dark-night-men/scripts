

testdir ()
{
    export IFS=$'\n';
    ls -1 $1|egrep -q "^.*\.(avi|mkv|mp4|mpg|flv|wmv)$"
}


do_fempty ()
{

    if [[ -z "$1" ]] ; then
        echo "Find path must be specified."
    fi

export -f testdir

OLDIFS=$IFS
export IFS=$'\n'

#find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
find "$@" \
 -type d \( -path "*/video2/exec/*" -o -path "*/VOBS" -o -path "*/@eaDir" -o -path "*/.Trash-1000"\
 -o -ipath "*/Russian\ Subtitles" \
 -o -ipath "*/Subs" \
 -o -ipath "*/*.Rus.Eng.Sub" \
 -o -ipath "*/Rus\ Subs" \
 -o -ipath "*/Eng\ subs" \
 -o -ipath "*/Eng\ Subs" \
 -o -ipath "*/English\ subs" \
 -o -ipath "*/Subtitles" \
 -o -ipath "*/Sub\ Eng" \
 -o -ipath "*/Sub\ Rus" \
 -o -ipath "*/Subs\ Eng" \
 -o -ipath "*/Subs\ Rus" \
 -o -ipath "*/Eng\ sub" \
 -o -ipath "*/Rus\ sub" \
 -o -ipath "*/subtitle" \
 -o -ipath "*/sub" \
 -o -ipath "*/sub.en" \
 -o -ipath "*/English subtitles" \
 -o -ipath "*/eng" \
 \) \
 -prune -o \
 -links 2 \
 -type d \
 -not -exec bash -c ' testdir "$0"' {} \; \
 -print

export IFS=$OLDIFS
}

fempty ()
{
    #do_fempty /home/zerg/export/DiskStation/videow/movies_proxy /home/zerg/export/DiskStation/video2 
    do_fempty /home/zerg/export/DiskStation/video*/movies_proxy* /home/zerg/export/DiskStation/video2
}

#-mindepth 0 -maxdepth 2 \

#-not -exec sh -c ' ls -1 {}|egrep -q "^.*\.(avi|mkv)$"' \; \
# -prune -o -exec sh -c 'ls -1 {}' \; \

 #-type d \( -path "*/VOBS/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) \

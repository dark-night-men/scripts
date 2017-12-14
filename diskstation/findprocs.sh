findx ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -not -ipath "*$4*" -not -iname "*$3*" \( -iname "*$1*" -o -iname "*$2*" \) \) -print
}

findn ()
{
    echo $1

    find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type f \( -iname "*.mkv" -o -iname "*.avi" \) -cnewer "$1"  \) -print
}

findnd ()
{
    echo $1

    find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type d  -cnewer "$1"  -exec stat  -c "%n %y" {} \; \) -print
}

findn1 ()
{
    echo Under construction. Exit.
    return 1

    if [[ -z "$1" ]] ; then
        echo "Path must be specified"
        return 1
    fi

    echo $1

    #find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$1"  \) -print
    find "$1" -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$2"  \) -print
}

findn2 ()
{
    if [[ -z "$1" ]] ; then
        echo "Path must be specified"
        return 1
    fi

    TimeStampFile="/tmp/datestamp"

    #if ! { [[ -n "$2" ]] && [[ -f "$2" ]] ; } ; then
    #    echo "File $2 with arg 2 does not exist."
        echo "Trying to create file $TimeStampFile with 2 weeks ago timestamp"

        if ! date4File=`date -R --date="2 weeks ago"` ; then
            echo "Date gen FAILED. Exit"
            return 2
        fi

        if ! touch -d "$date4File" "$TimeStampFile"; then
            echo "Can not create file $TimeStampFile with stamp $date4File. Exit."

            return 3
        else
            echo "File $TimeStampFile with stamp $date4File created."
            ls -l $TimeStampFile
        fi

    #else

    #    TimeStampFile=$2
    #fi


    echo $1

    #find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$1" -exec stat  -c "%n %y" {} \;  \) -print

    #find "$1" -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$TimeStampFile" -exec stat  -c "%n %y" {} \;  \) -print

    #find "$@"  \( -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$TimeStampFile" -exec stat  -c "%n %y" {} \;  \) -print
    find "$@" -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$TimeStampFile" -printf "%T+\t%p\n"
}

findxd ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type d -not -ipath "*$4*" -not -iname "*$3*" \( -iname "*$1*" -o -iname "*$2*" \) \) -print
}

findxd1 ()
{
    echo $1

    find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type d -iname "*$1*" \) -print
}

findxm ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -ipath "*/*series*/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -iname "*$1*" -o -iname "*$2*" \) -print
}

findxmd ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -ipath "*/*series*/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -iname "*$1*" -o -iname "*$2*" \) -print
}

fn2prox ()
{

    #timeout 1 `findn2 /home/zerg/export/DiskStation/videow*/movies_proxy*`
    #findn2 /home/zerg/export/DiskStation/videow*/movies_proxy*
    findn2 /home/zerg/export/DiskStation/video2

}

alias src="source"
alias c="cd .."
alias c2="c ; c"
alias c3="c ; c ; c"
alias lh=" ls -alt | head -n20"

alias mk="~/scripts/mk.sh make make"
alias mku="~/scripts/mk.sh make"
alias mks="~/scripts/mk.sh"
alias tmux="TERM=xterm-256color tmux"
alias make="make -j8"
alias d="gdb ./elasticnodes -c ./core -tui"

alias gitgraph="git log --graph --full-history --all --color \
            --pretty=format:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s\""
alias ei="echo DISPLAY $DISPLAY"
alias em="if ls -l ./main.cpp | grep ^l ; then echo 1; else echo 0; fi"
alias lsm="ls -l main.cpp"

alias run="./build/$ZRUN"

alias dcfl="declare -F | grep -v ' _'"
alias dcf="declare -f"

lns ()
{
    if [[ -n "$1" ]] ; then
        echo "Argument provided >$1<"
    else
        echo "Argument is demanded"
        exit 1
    fi

    if ls -l ./main.cpp | grep -q ^l ; then
        rm -v ./main.cpp;
    fi

    ln -sv "$1" ./main.cpp
}

findxd ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \
    \( -type d -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -print
}

findx ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print
}

findxm ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/*series*/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print
}

findxmd ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/*series*/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \
        \( -iname "*$1*" -o -iname "*${2-$1}*" \) \
    \) `#-print` \
    -printf '%p %y\n' \

    #-exec bash -c '#set -x;
    #    IFS=$(echo -en "\n\b");
    #    file="$0"; 
    #    [ "$(ls -ldA $file >& /dev/null | grep -l ^d)" ] && echo "dir" || echo "file"
    #    #echo "$file" ;
    #    ' {} \;   

    #\) -type f -print
    #[ "$(ls -ldA fist | grep -l ^d)" ] && echo "dir" || echo "file"
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

    find "$@" -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$TimeStampFile" -printf "%T+\t%p\n"
}

fn2prox ()
{
    findn2 /home/zerg/export/DiskStation/video{{,1}/movies_proxy*,2}
}

findxb ()
{
    echo $1

find /home/zerg/export/DiskStation/books* \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print
}

gdb_alias()
{
    gdb "$1" -c "$2"  -tui
}
alias d="gdb_alias"
alias mc1="make clean; make"
alias mc="pushd build; make clean; make; pushd;"
alias ta="tmux attach"
alias vimp="env CSENABLED=true vim"
alias ling="links google.com"

alias cst="export CSENABLED=true; env | grep CSENABLED"
alias ucs="unset CSENABLED"
alias cschk="[[ -v CSENABLED ]] && { echo 'CSENABLED TRUE'; } || { echo 'CSENABLED FALSE'; } "

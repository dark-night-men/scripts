alias src="source"
alias srca="src ~/.bash_aliases"
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
        return 1
    fi

    if ls -l ./main.cpp | grep -q ^l ; then
        rm -v ./main.cpp;
    fi

    ln -sv "$1" ./main.cpp
}

lnm ()
{
    if [[ -n "$1" ]] ; then
        echo "Argument provided >$1<"
    else
        echo "Argument is demanded"
        return 1
    fi

    if ls -l ./main_main.cpp | grep -q ^l ; then
        rm -v ./main_main.cpp;
    fi

    ln -sv "$1" ./main_main.cpp
}


findxd ()
{
    echo $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
    \( -type d -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -print
}

findx ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print
}


#find in current dir
findxc ()
{
    echo $1

    find "$PWD" -maxdepth ${5-99} \
        \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
        \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print
}

findxm ()
{
    echo $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/*series*/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "*/#recycle" \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print
}

findxp ()
{
    echo $1

find /home/zerg/export/DiskStation/video2/download /home/zerg/export/DiskStation/video/new /home/zerg/export/DiskStation/video1/remifa \
    -maxdepth ${5-99} \
    \( -path "*/*series*/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
    \( -regextype egrep  \
    -iregex "^.*$1.*\.(avi|mkv|mp4|mpg|flv|wmv|ts)$" -type f -print \)
}

findxmd ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/*series*/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
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
        echo "Trying to create file $TimeStampFile "

        #if ! date4File=`date -R --date="2 weeks ago"` ; then
        #if ! date4File=`date --debug -R --date="${2:-'3 days ago'}"` ; then
        ####if ! date4File=`date -R --date="${2:-'3 days ago'}"` ; then
        if ! date4File=`date -R --date="${2:-3 days ago}"` ; then
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
    printf '\n'

    #find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$1" -exec stat  -c "%n %y" {} \;  \) -print

    #find "$1" -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$TimeStampFile" -exec stat  -c "%n %y" {} \;  \) -print

    #find "$@"  \( -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$TimeStampFile" -exec stat  -c "%n %y" {} \;  \) -print

    #OK#find $1 -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$"  -cnewer "$TimeStampFile" -printf "%T+\t%p\n"

    find $1 \
        -type d \( -path "*/.Trash-1000/*" -o -path "*/@eaDir/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
        \( \
            -type f -regextype egrep -regex "^.*\.(avi|mkv|mp4|mpg|flv)$" \
            -cnewer "$TimeStampFile" \
        \) \
        -printf "%T+\t%p\n" \
    \
    | sort -r
}

#Одинарные кавычки - не парсить - парсить через два этапа
#Двойные кавычки - на следующем уровне парсить до упора
#Нет кавычек - парсить до упора по пробелам как в командной строке
fn2prox ()
{
    #findn2 "/home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy*" "$1" 
    #findn2 "/home/zerg/export/DiskStation/video{{,1}/movies_proxy*,2}" "$1"
    FPATHS=$( echo /home/zerg/export/DiskStation/video{{,1}/movies_proxy*,2} ) 
    findn2 "$FPATHS" "$1"

    #timeout 1 `findn2 /home/zerg/export/DiskStation/videow*/movies_proxy*`

    #findn2 '/home/zerg/export/DiskStation/video*/movies_proxy*' "$1"

    #findn2 /home/zerg/export/DiskStation/video2

}

findxb ()
{
    echo $1

find /home/zerg/export/DiskStation/books* \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/#recycle"  \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print
}

findxb1 ()
{
    echo $1

find /home/zerg/export/DiskStation/video2/queue_books \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*"  -o -path "*/#recycle" \) -prune -o \
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

alias vim="env LC_ALL=en_US.utf8 vim"
alias vimp="env LC_ALL=en_US.utf8 CSENABLED=true vim"

alias vip="env LC_ALL=en_US.utf8 CSENABLED=true DEV8ELENABLED=true vim"
alias vimn="env LC_ALL=en_US.utf8 NOVELENABLED=true ALEDISABLED=true vim"
alias vimq="env LC_ALL=en_US.utf8 NOVELENABLED=true CSENABLED=true vim"

alias ling="links google.com"

alias cst="export CSENABLED=true; env | grep CSENABLED"
alias ucs="unset CSENABLED"
alias cschk="[[ -v CSENABLED ]] && { echo 'CSENABLED TRUE'; } || { echo 'CSENABLED FALSE'; } "

alias uus="sudo apt update && sudo apt upgrade && sudo apt autoremove"
alias uusp="sudo apt update && sudo apt upgrade && sudo shutdown -h"
#
alias top20="du -BG -d1 | sort -hr | head"
alias vs="$VIMRUNTIME/macros/less.sh"

alias grep=egrep
alias shortps="export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '"

alias j=jobs
alias h=history
alias l=less

alias gh1='git hist1 | less'
alias gh2='git hist1 | head -n3'
alias gn1='git nstat | less'

alias uncnv="env LD_LIBRARY_PATH=/usr/lib/libreoffice/program:${LD_LIBRARY_PATH} unoconv" 

alias srcba='src ~/.bash_aliases'

vlcp(){
    local o=$IFS
    #IFS=$(echo -en "\n\b")
    IFS="$(printf '\n\t')"
    #IFS=$'\n'
    #vlc "$(cat $@)"
    ls -l "$(cat $@)"
    IFS=$o
}


alias hmount="sudo mount.cifs //33.0.0.16/HyperVShared ~/export/HyperVShared -o user=agibalov,uid=zerg,gid=zerg"

alias mkb="mkdir -v build && pushd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .. && make && pushd"

alias mkd='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..'
alias mkd1='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_RULE_MESSAGES:BOOL=OFF  ..'

alias mkv='make VERBOSE=1 --no-print-directory'

alias f="find"

alias rs="rsync -ah --progress"

alias pho='nice -n +40 ~/tmp/tmpscripts/photo_tools/pack_img.sh '
alias ds='du -ksh * | sort -hr'
alias ph='find -mindepth 1  -maxdepth 1 -type d -exec nice -n +40 ~/tmp/tmpscripts/photo_tools/pack_img.sh {} \; '

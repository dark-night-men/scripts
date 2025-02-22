alias sudo="env LC_ALL=en_US.utf8 sudo"
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

findxd0 ()
{
    printf '%s\0' $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
    \( -type d -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -print0
}


findx ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print
}

# man for find -mtime option:
# 
# You can write -mtime 6 or -mtime -6 or -mtime +6:
# 
# Using 6 without sign means "equal to 6 days old — so modified between 'now - 6 * 86400' and 'now - 7 * 86400'" (because fractional days are discarded).
# Using -6 means "less than 6 days old — so modified on or after 'now - 6 * 86400'".
# Using +6 means "more than 6 days old — so modified on or before 'now - 7 * 86400'" (where the 7 is a little unexpected, perhaps).

#find files that, BY DEFAULT, "less than 3 days old"
findxt ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "/home/zerg/export/DiskStation/video2/#recycle" \) -prune -o \
    -mtime ${1--3}  -printf "%T+\t%p\n" 
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

findxm0 ()
{
    printf '%s\0' $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* \
    -maxdepth ${5-99} \
    \( -path "*/*series*/*" -o -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" -o -path "*/queue_books/*" -o -path "*/#recycle" \) -prune -o \
    \( -not -ipath "*${4-zzzzzzzzzz}*" -not -iname "*${3-zzzzzzzzzzzzz}*" \( -iname "*$1*" -o -iname "*${2-$1}*" \) \) -type f -print0
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

#find DIR in WSL among ZTORRENT exclude CART
findw_zd ()
{
    echo $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos/\!ZTORRENT/ \
        /mnt/d/\!D_VIDEO/\!ZTORRENT/ \
        /mnt/e/\!E_VIDEO/\!ZTORRENT/ \
        /mnt/f/\!F_VIDEO/\!Z_TORRENT/ \
        -ipath '*/\!CART_DIR/*' \
        -prune -o \
        -type d \( -iname "*$1*" -o -iname "*${2-$1}*" -o -iname "*${3-$1}*" -o -iname "*${4-$1}*"  \) -print
}


#find DIR in WSL among ZTORRENT exclude CART. Using -print0 in find for zero-separated lines.
findw_zd0 ()
{
    printf '%s\0' $1 1>&2

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos/\!ZTORRENT/ \
        /mnt/d/\!D_VIDEO/\!ZTORRENT/ \
        /mnt/e/\!E_VIDEO/\!ZTORRENT/ \
        /mnt/f/\!F_VIDEO/\!Z_TORRENT/ \
        -ipath '*/\!CART_DIR/*' \
        -prune -o \
        -type d \( -iname "*$1*" -o -iname "*${2-$1}*" -o -iname "*${3-$1}*" -o -iname "*${4-$1}*"  \) -print0
}

#find WSL among ZTORRENT exclude CART
findw_z ()
{
    echo $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos/\!ZTORRENT/ \
        /mnt/d/\!D_VIDEO/\!ZTORRENT/ \
        /mnt/e/\!E_VIDEO/\!ZTORRENT/ \
        /mnt/f/\!F_VIDEO/\!Z_TORRENT/ \
        -ipath '*/\!CART_DIR/*' \
        -prune -o \
        \( -iname "*$1*" -o -iname "*${2-$1}*" -o -iname "*${3-$1}*" -o -iname "*${4-$1}*"  \) -print
}

#find WSL among ZTORRENT exclude CART. Using -print0 in find for zero-separated lines.
findw_z0 ()
{
    printf '%s\0' $1 1>&2

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos/\!ZTORRENT/ \
        /mnt/d/\!D_VIDEO/\!ZTORRENT/ \
        /mnt/e/\!E_VIDEO/\!ZTORRENT/ \
        /mnt/f/\!F_VIDEO/\!Z_TORRENT/ \
        -ipath '*/\!CART_DIR/*' \
        -prune -o \
        \( -iname "*$1*" -o -iname "*${2-$1}*" -o -iname "*${3-$1}*" -o -iname "*${4-$1}*"  \) -print0
}

#find DIR in WSL among !heap 
findw_hd ()
{
    echo $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos/\!heap/ /mnt/{d,e,f}/\!heap/ \
        -type d \( -iname "*$1*" -o -iname "*${2-$1}*" -o -iname "*${3-$1}*" -o -iname "*${4-$1}*"  \)
}

#find DIR in WSL among !heap. Using -print0 in find for zero-separated lines.
findw_hd0 ()
{
    printf '%s\0' $1 1>&2

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos/\!heap/ /mnt/{d,e,f}/\!heap/ \
        -type d \( -iname "*$1*" -o -iname "*${2-$1}*" -o -iname "*${3-$1}*" -o -iname "*${4-$1}*"  \)\
        -print0
}

#find FILE or DIR in WSL among !heap 
findw_h ()
{
    echo $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos/\!heap/ /mnt/{d,e,f}/\!heap/ \
        \( -iname "*$1*" -o -iname "*${2-$1}*" -o -iname "*${3-$1}*" -o -iname "*${4-$1}*"  \)
}


#find in Videos in WSL
findwv ()
{
    echo $1

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos \
        \( -iname "*$1*" -o -iname "*${2-$1}*" -o -iname "*${3-$1}*" -o -iname "*${4-$1}*"  \)
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
alias gvip="env LC_ALL=en_US.utf8 CSENABLED=true DEV8ELENABLED=true gvim"
alias vimn="env LC_ALL=en_US.utf8 NOVELENABLED=true ALEDISABLED=true vim"
alias vimq="env LC_ALL=en_US.utf8 NOVELENABLED=true CSENABLED=true vim"

alias ling="links google.com"

alias cst="export CSENABLED=true; env | grep CSENABLED"
alias ucs="unset CSENABLED"
alias cschk="[[ -v CSENABLED ]] && { echo 'CSENABLED TRUE'; } || { echo 'CSENABLED FALSE'; } "

alias uus="env LC_ALL=en_US.utf8 sudo apt update && env LC_ALL=en_US.utf8 sudo apt upgrade && env LC_ALL=en_US.utf8 sudo apt autoremove"
alias uusp="sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo shutdown -h +5"
alias uuspi="sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo shutdown -h"
alias ma="sudo mount -a"
alias mu="(sudo mount -a) && ( sudo apt update && sudo apt upgrade && sudo apt autoremove )"
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
alias alsen="env LANG='en_EN.UTF-8'"
alias alslsc="env LS_COLORS=''"

alias l1="env LS_COLORS='' ls"
alias l="env LS_COLORS='' ls | head"

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

alias fest="festival --tts --language russian"

alias shd='sudo shutdown -h 0'

alias rs="rsync -ah --progress"

alias pho='nice -n +40 ~/tmp/tmpscripts/photo_tools/pack_img.sh '
alias ds='du -ksh * | sort -hr'
alias ph='find -mindepth 1  -maxdepth 1 -type d -exec nice -n +40 ~/tmp/tmpscripts/photo_tools/pack_img.sh {} \; '

alias t="env LC_ALL=en_US.utf8 time --format='%E'" 

alias z="|& tee /tmp/log"
alias sss="sudo service ssh start"

alias nxfix="
sudo /etc/NX/nxserver --eglcapture yes
sudo systemctl restart display-manager
sudo /etc/NX/nxserver --restart
"

alias cdm="cd /mnt/c/Users/serge/Videos"
alias cdc="cd /mnt/c/Users/serge/Videos"
alias cdd="cd /mnt/d/!heap"
alias cde="cd /mnt/e/!heap"
alias cdf="cd /mnt/f/!heap"

alias redjpgold="env LC_ALL=en_US.utf8  time --format='\n elapsed time %E \n' find -type f -iname '*.jp*g' -size +1M -not -name '*ReDuCeD*'  -exec mogrify -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB {} \; -exec rename -v -f 's/(\.jpe?g)$/.ReDuCeD\1/' {} \; -printf '%p %k KB\n' |& tee /tmp/moglog"

redjpg ()
{
    printf '\nredjpg STARTED at %s\n' "$(date)"

    env LC_ALL=en_US.utf8  time --format='\n elapsed time %E \n' find -type f -iname '*.jp*g' -size +1M -not -name '*ReDuCeD*'  -exec mogrify -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB {} \; -exec rename -v -f 's/(\.jpe?g)$/.ReDuCeD\1/' {} \; -printf '%p %k KB\n' |& tee /tmp/moglog

    printf '\nredjpg FINISHED at %s\n' "$(date)"

}

alias png2jpgold="env LC_ALL=en_US.utf8  time --format='\n elapsed time %E \n' find -type f -iname '*.png' -size +1M -exec mogrify -format jpg {} \; -exec rm -v {} \; |& tee /tmp/png2jpglog"

png2jpg ()
{
    printf '\npng2jpg STARTED at %s\n' "$(date)"

    env LC_ALL=en_US.utf8  time --format='\n elapsed time %E \n' find -type f -iname '*.png' -size +1M -exec mogrify -format jpg {} \; -exec rm -v {} \; |& tee /tmp/png2jpglog

    printf 'png2jpg FINISHED at %s\n' "$(date)"

}

psd2jpg ()
{
    # set -x;

    printf '\npsd2jpg STARTED at %s\n' "$(date)"

    find -type f -iname '*.psd' -exec mogrify -verbose -format jpg {} \; -exec rm -v {} \; -exec bash -c ' qqq=$(echo $0 |sed "s/\.psd/-[1-9][0-9]*\.jpg/") ; printf "qqq >%s<\n" "$qqq"; export IFS=$(echo -en "\n\b"); find -type f -regextype egrep -regex "$qqq" -delete -print  ; ' {} \; |& tee /tmp/psd2jpglog 

    printf 'psd2jpg FINISHED at %s\n' "$(date)"

    # set +x;
}

# alias resimg="LC_ALL=en_US.utf8  time --format='\n elapsed time %E \n' find -type f -iname '*.jp*g' -exec mogrify -verbose -resize 2500x1500\> {} \; |& tee /tmp/resize_image.log"

rsimg ()
{
    printf '\nrsimg STARTED at %s\n' "$(date)"


    date |& tee -a /tmp/resize_image.log
    start=$(date +%s)

    for size_threshold in $(seq 10 -1 0) ; do  

        printf '\nSize threshold %s' $size_threshold |& tee -a /tmp/resize_image.log

        env LC_ALL=en_US.utf8  time --format=' elapsed time %E \n' find -type f -iname '*.jp*g' -size +${size_threshold}M -not -name '*ReSiZeD*' \( -exec mogrify -verbose -resize 2500x1500\> {} \; -o -exec true \; \) -exec rename -v -f 's/(\.jpe?g)$/.ReSiZeD\1/' {} \; -printf '%p %k KB\n'|& tee -a /tmp/resize_image.log
    done
    

    end=$(date +%s)

    # $ date -d@36 -u +%H:%M:%S

    DURATION=$(date -d@$(($end-$start)) -u +%H:%M:%S)
    printf '\n rsimg TOTAL elapsed time %s \n' $DURATION |& tee -a /tmp/resize_image.log

    printf 'rsimg FINISHED at %s\n' "$(date)"
}

alias info="info --vi"

alias im="( touch /tmp/im_alias_start.log;  psd2jpg; png2jpg;  redjpg; rsimg; touch /tmp/im_alias_stop.log; ) |& tee /tmp/im.log"

alias rmlnk="find -regextype egrep  -iregex '.*\([2-9]\)\.lnk' -print -delete"
alias rmlnkqb="find -type f -name '*!qB*ярлык.lnk' -print -delete"

#~/tmp/tts.sh BEGIN
##!/bin/bash

#cat > /tmp/buffer.txt

#edge-playback  --voice ru-RU-SvetlanaNeural -f /tmp/buffer.txt
## edge-playback  --voice ru-RU-SvetlanaNeural --text "$1"
#~/tmp/tts.sh END

tts_edge ()
{
    if [[ -z "$1" ]] ; then
        echo "File with book must be specified"
        return 1
    fi

    # cat "$1"   | parallel  -j 1 --pipe  --max-args 3  ~/tmp/tts.sh
    yes "$(<$1)" | cat -s   | parallel  -j 1 --pipe  --max-args 3  ~/tmp/tts.sh
}

alias fd="fd --color auto"

mv_insta_pics ()
{

    env LC_ALL=en_US.utf8  time --format=' elapsed time %E \n' find /mnt/c/Users/serge/Downloads -type f -regextype egrep -iregex  '.*[[:alnum:]_.]+_[_0-9]{37,}\.(mp4|jpeg|jpg|webp|heic|png)' -exec   mv -v -t /mnt/e/IDownload/tmp {} \; |& tee ~/tmp/mv_insta_pics.log

}


#remove qbittorrent files - *.parts *.!qB
qb_rm ()
{

    env LC_ALL=en_US.utf8 time --format='%E' \
        \
    find /mnt/c/Users/serge/Videos/\!heap \
        /mnt/c/Users/serge/Videos/\!ZTORRENT \
        /mnt/{d,e,f}/\!heap/ \
        /mnt/d/\!D_VIDEO/ \
        /mnt/e/\!E_VIDEO/ \
        /mnt/f/\!F_VIDEO/ \
        \( -iname '*.parts' -o -iname '*.!qB'  \) \
        -delete \
        -print


    # find /mnt/c/Users/serge/Videos/{\!heap,\!ZTORRENT}/ /mnt/{d,e,f}/{\!heap/,\!{D,E,F}_VIDEO}/ \
}

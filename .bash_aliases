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

findx ()
{
    echo $1

find /home/zerg/export/DiskStation/video2 /home/zerg/export/DiskStation/video*/movies_proxy* -type d \( -path "*/@eaDir/*" -o -path "*/.Trash-1000/*" \) -prune -o \( -not -ipath "*$4*" -not -iname "*$3*" \( -iname "*$1*" -o -iname "*$2*" \) \) -print
}

#!/bin/bash

die() {
    echo >&2 "$@"
    exit 1
}

#[ "$#" -eq 1 ] || die "Pakage name expected as arg1. 1 argument required, $# provided"

examp() {
echo $1 | grep -E -q '^[0-9]+$' || die "Numeric argument required, $1 provided"

while read dir 
do
    [ -d "$dir" ] || die "Directory $dir does not exist"
        rm -rf "$dir"
done <<EOF
~/myfolder1/$1/anotherfolder 
~/myfolder2/$1/yetanotherfolder 
~/myfolder3/$1/thisisafolder
EOF
}


QTLOGS=/export/home/<USER>/tmp/creator
##PKGS=/net/<HOST>/export/home/<USER>/tools/pkgs/

PKGS=/net/<HOST>/export/home/<USER>/tools
FP=/net/<HOST>/export/home/<USER>/tools/pkgs
GRID=/grid/common/pkgs
LLP=/latest/lib/pkgconfig
LI=/latest/include
LL=/latest/lib
LX=/latest/libexec
LB=/latest/bin
LS=/latest/share
PYPATH=${GRID}/python/v2.7.2
XCB_PATH=/export/home/<USER>/downloads/xcb
##XCB_PATH=/export/home/<USER>/downloads/xcb1
XCB_BUILD=/xcb_build
LEXPATH=${GRID}/flex/v2.5.37/bin
##GCC1=${GRID}/gcc${LB}
##GCC1=${GRID}/gcc/v4.1.1/bin

#/usr/bin/gcc
GCC1=""

AUTOTOOLS=${GRID}/m4${LB}:${GRID}/autoconf${LB}:${GRID}/automake${LB}:${GRID}/autogen${LB}
#AUTOTOOLS=${FP}/autoconf/autoconf-2.69/bin:${GRID}/automake${LB}:${GRID}/autogen${LB}


prefix() {

    [ "$#" -eq 1 ] || die "prefix function : 1 argument required, $# provided"

    PREFIX=$PKGS$1
    echo "PREFIX $PREFIX"

    echo "Is target directory $PREFIX is OK ? "
    select choice in yes no ;  do
        echo $choice
        break
    done    

    case "$choice" in
        yes) ;;
        no|*) die "Exiting ..." ;;
    esac

    if [[ -d "$PREFIX"  ]] ; then 

        echo "Directory $PREFIX already exists.  ?"
        select choice in remove 'exit' 'continue';  do
            echo $choice
            break
        done    

        case "$choice" in
            remove) rm -rfv $PREFIX ;;
            'continue') ;;
            'exit'|*) die "Exiting ..." ;;
        esac

    else
        mkdir -p $PREFIX
    fi    
}

##setenv PK /libffi/libffi-3.0.13

# base
##./configure --prefix $PREFIX

glib_cnf() {
#glib 

    PK=/pkgs/glib/glib-2.36.3
    prefix $PK   

    D1=/libffi-3.0.13
    P1=/libffi
    PT=${FP}$P1$D1

    ##env PKG_CONFIG_PATH="/grid/common/pkgs/pkgconfig/latest/" LIBFFI_CFLAGS="-I$PT/lib/$D1/include"  LIBFFI_LIBS="-L$PT/lib64 -L$PT/lib" ./configure --prefix $PREFIX
    env PATH=${GRID}/autoconf${LB}:/export/home/<USER>/downloads:${GRID}/gettext${LB}:${PATH} PKG_CONFIG_PATH="${GRID}/pkgconfig/latest/" LIBFFI_CFLAGS="-I$PT/lib/$D1/include"  LIBFFI_LIBS="$PT/lib64/libffi.la" ./configure --prefix $PREFIX
}

glib_make() {
    local mlog
    mlog="make5.log"
##    `env PATH=/export/home/<USER>/downloads/glib-2.36.3:${FP}/automake${LB}:${GRID}/gettext${LB}:${PATH} make` >\& ${mlog} \&
    env PATH=${GRID}/autoconf${LB}:/export/home/<USER>/downloads:${GRID}/gettext${LB}:${PATH} make
}

pkg_cnf() {
#pkg-config

    PK=/pkg-config/pkg-config-0.28
    prefix $PK   

    D1=libffi-3.0.13
    P1=libffi
    PT=$PKGS$P1/$D1

    ##env LIBFFI_CFLAGS="-I$PT/lib/$D1/include"  LIBFFI_LIBS="-L$PT/lib64 -L$PT/lib" ./configure --prefix $PREFIX
    ./configure --prefix $PREFIX

}

qtutil() {


    ##env LIBFFI_CFLAGS="-I$PT/lib/$D1/include"  LIBFFI_LIBS="-L$PT/lib64 -L$PT/lib" ./configure --prefix $PREFIX

    ## env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/gst-plugins-base${LLP}:${FP}/gstreamer${LLP}:${FP}/dbus${LLP}" \
    ##LD_LIBRARY_PATH=${FP}/gstreamer/${LL}:${FP}/gstreamer$LX:${FP}/dbus/${LL}:${FP}/dbus$LX:${FP}/dbus/latest/var/lib:${FP}/glib/${LL}\


    env PYTHON2="${PYPATH}/bin/python" \
        PYTHONPATH="${FP}/libxml2-python/latest/lib/python2.7/site-packages:${PYTHONPATH}" \
        LD_LIBRARY_PATH=${FP}/pthread-stubs${LL}:${FP}/libxcb${LL}:${FP}/gst-plugins-bad${LL}:${FP}/gst-plugins-base${LL}:${FP}/libxcb/${LL}:${FP}/gstreamer/${LL}:${FP}/gstreamer$LX:${FP}/dbus/${LL}:${FP}/dbus$LX:${FP}/dbus/latest/var/lib:${FP}/glib/${LL}\
        SED="${GRID}/sed${LB}/sed" \
        LEX="${LEXPATH}/flex" \
        PKG_CONFIG="${GRID}/pkgconfig${LB}/pkg-config" \
        PKG_CONFIG_PATH="${FP}/pthread-stubs${LLP}:${FP}/libxcb${LLP}:${FP}/glib${LLP}:${FP}/gst-plugins-base${LLP}:${FP}/gstreamer${LLP}:${FP}/dbus${LLP}" \
        PATH=${GRID}/intltool${LB}:${GCC1}:${LEXPATH}:${GRID}/llvm${LB}:${FP}/libtool${LB}:${AUTOTOOLS}:${GRID}/gettext${LB}:${FP}/xmlto${LB}:${FP}/python2${LB}:${PYPATH}/bin:${GRID}/git${LB}:${PATH} \
        \
        "$@"
}

qtcnf() {

    killall tail

    PK=/Qt/Qt-5.1.0
    prefix $PK   

    qtutil ./configure -prefix "$PREFIX" -D"SYS_perf_event_open=0"  -I"/usr/include" -I"${GRID}/openssl$LI" -I"$FP/glib$LI" -I "$FP/gst-plugins-base$LI/gstreamer-1.0" -I"$FP/gst-plugins-base$LI" -I"$FP/gstreamer$LI" -I"$FP/dbus$LI" -L"${GRID}/openssl$LL" -L"$FP/glib$LL" -L"$FP/gst-plugins-base$LL" -L"$FP/gstreamer$LL" -L"$FP/dbus$LL" -l"gstapp-0.10" -dbus -release -commercial -confirm-license -qt-pcre -force-debug-info >& ${QTLOGS}/qtcnf.log &

    tail -F ${QTLOGS}/qtcnf.log &

}

qtmake() {

    killall tail

    qtutil make "$@"  >& ${QTLOGS}/qtmake.log &

    tail -F ${QTLOGS}/qtmake.log &
}

qtcnf4() {

    local THISVER='/qt-everywhere-opensource-src-4.7.2'

    if [[ ! ( -d ${QTLOGS}${THISVER} && -e ${QTLOGS}${THISVER} )  ]] ; then
        echo "${QTLOGS}${THISVER} does not exists . Exit...  "
        exit 1
    else
        echo "${QTLOGS}${THISVER} exists . OK...  "
    fi


    killall tail

    PK=/Qt/Qt-4.7.2
    prefix $PK   

    qtutil ./configure -prefix "$PREFIX" -D"SYS_perf_event_open=0"  -I"/usr/include" -I"${GRID}/openssl$LI" -I"$FP/glib$LI" -I "$FP/gst-plugins-base$LI/gstreamer-1.0" -I"$FP/gst-plugins-base$LI" -I"$FP/gstreamer$LI" -I"$FP/dbus$LI" -L"${GRID}/openssl$LL" -L"$FP/glib$LL" -L"$FP/gst-plugins-base$LL" -L"$FP/gstreamer$LL" -L"$FP/dbus$LL" -l"gstapp-0.10" -dbus -release -opensource -confirm-license -debug >& ${QTLOGS}${THISVER}/qtcnf.log &

####-commercial -confirm-license

    tail -F ${QTLOGS}${THISVER}/qtcnf.log &

}

qtmake4() {
    local THISVER='/qt-everywhere-opensource-src-4.7.2'

    if [[ ! ( -d ${QTLOGS}${THISVER} && -e ${QTLOGS}${THISVER} )  ]] ; then
        echo "${QTLOGS}${THISVER} does not exists . Exit...  "
        exit 1
    else
        echo "${QTLOGS}${THISVER} exists . OK...  "
    fi


    killall tail

    qtutil make "$@"  >& ${QTLOGS}${THISVER}/qtmake.log &

    tail -F ${QTLOGS}${THISVER}/qtmake.log &
}


qtcnfx() {

##local THISVER='/qt-everywhere-opensource-src-4.7.2'
    local THISVER="/qt-everywhere-opensource-src-$1"

    if [[ ! ( -d ${QTLOGS}${THISVER} && -e ${QTLOGS}${THISVER} )  ]] ; then
        echo "${QTLOGS}${THISVER} does not exists . Exit...  "
        exit 1
    else
        echo "${QTLOGS}${THISVER} exists . OK...  "
    fi


    killall tail

##PK=/Qt/Qt-4.7.2
    local PK="/Qt/Qt-$1"
    prefix $PK   

    ##-D"SYS_perf_event_open=0"
    qtutil ./configure -prefix "$PREFIX" -I"/usr/include" -I"${GRID}/openssl$LI" -I"$FP/glib$LI" -I "$FP/gst-plugins-base$LI/gstreamer-1.0" -I"$FP/gst-plugins-base$LI" -I"$FP/gstreamer$LI" -I"$FP/dbus$LI" -L"${GRID}/openssl$LL" -L"$FP/glib$LL" -L"$FP/gst-plugins-base$LL" -L"$FP/gstreamer$LL" -L"$FP/dbus$LL" -l"gstapp-0.10" -dbus -release -opensource -confirm-license -debug >& ${QTLOGS}${THISVER}/qtcnf.log &

####-commercial -confirm-license

    tail -F ${QTLOGS}${THISVER}/qtcnf.log &

}

qtmakex() {
    ##local THISVER='/qt-everywhere-opensource-src-4.7.2'
    local THISVER="/qt-everywhere-opensource-src-$1"
    shift

    if [[ ! ( -d ${QTLOGS}${THISVER} && -e ${QTLOGS}${THISVER} )  ]] ; then
        echo "${QTLOGS}${THISVER} does not exists . Exit...  "
        exit 1
    else
        echo "${QTLOGS}${THISVER} exists . OK...  "
    fi


    killall tail

    qtutil make "$@"  >& ${QTLOGS}${THISVER}/qtmake.log &

    tail -F ${QTLOGS}${THISVER}/qtmake.log &
}


creatorutilx() {

##local QTDIRPATH="/export/home/<USER>/tools/Qt/Qt-4.7.2"
    local QTDIRPATH="/export/home/<USER>/tools/Qt/Qt-$1"
    shift

    env PYTHON2="${PYPATH}/bin/python" \
        QTDIR="${QTDIRPATH}" \
        PYTHONPATH="${FP}/libxml2-python/latest/lib/python2.7/site-packages:${PYTHONPATH}" \
        LD_LIBRARY_PATH=${FP}/pthread-stubs${LL}:${FP}/libxcb${LL}:${FP}/gst-plugins-bad${LL}:${FP}/gst-plugins-base${LL}:${FP}/libxcb/${LL}:${FP}/gstreamer/${LL}:${FP}/gstreamer$LX:${FP}/dbus/${LL}:${FP}/dbus$LX:${FP}/dbus/latest/var/lib:${FP}/glib/${LL}\
        SED="${GRID}/sed${LB}/sed" \
        LEX="${LEXPATH}/flex" \
        PKG_CONFIG="${GRID}/pkgconfig${LB}/pkg-config" \
        PKG_CONFIG_PATH="${QTDIRPATH}/lib/pkgconfig:${FP}/pthread-stubs${LLP}:${FP}/libxcb${LLP}:${FP}/glib${LLP}:${FP}/gst-plugins-base${LLP}:${FP}/gstreamer${LLP}:${FP}/dbus${LLP}" \
        PATH=${GRID}/intltool${LB}:${GCC1}:${LEXPATH}:${GRID}/llvm${LB}:${FP}/libtool${LB}:${AUTOTOOLS}:${GRID}/gettext${LB}:${FP}/xmlto${LB}:${FP}/python2${LB}:${PYPATH}/bin:${GRID}/git${LB}:${PATH} \
        \
        "$@"
}

creatormakex() {
    local THISVER="/qt-creator-$1-src"
    shift

    if [[ ! ( -d ${QTLOGS}${THISVER} && -e ${QTLOGS}${THISVER} )  ]] ; then
        echo "${QTLOGS}${THISVER} does not exists . Exit...  "
        exit 1
    else
        echo "${QTLOGS}${THISVER} exists . OK...  "
    fi


    killall tail

    local QTLIBVER="$1"
    shift

    creatorutilx "${QTLIBVER}" "$@"  >& ${QTLOGS}${THISVER}/creatorlog.log &

    tail -F ${QTLOGS}${THISVER}/creatorlog.log &
}

creatormake25() {
    local THISVER='/qt-creator-2.5.2-src'

    if [[ ! ( -d ${QTLOGS}${THISVER} && -e ${QTLOGS}${THISVER} )  ]] ; then
        echo "${QTLOGS}${THISVER} does not exists . Exit...  "
        exit 1
    else
        echo "${QTLOGS}${THISVER} exists . OK...  "
    fi


    killall tail

    creatorutil "$@"  >& ${QTLOGS}${THISVER}/creatorlog.log &

    tail -F ${QTLOGS}${THISVER}/creatorlog.log &
}
#===============================================================================

qt_cnf1() {

    PK=/Qt/Qt-5.1.0
    prefix $PK   
    ##env LIBFFI_CFLAGS="-I$PT/lib/$D1/include"  LIBFFI_LIBS="-L$PT/lib64 -L$PT/lib" ./configure --prefix $PREFIX
 env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/dbus${LLP}:${FP}/gst-plugins-bad${LLP}:${FP}/gst-plugins-base${LLP}:${FP}/gstreamer${LLP}" \
 LD_LIBRARY_PATH="${FP}/gst-plugins-bad${LL}:${FP}/dbus${LL}:${FP}/dbus$LX:${FP}/dbus/latest/var/lib:${FP}/glib/${LL}:${FP}/gstreamer/${LL}:${FP}/gstreamer$LX:${FP}/gst-plugins-base${LL}"\
 ./configure -prefix "$PREFIX" -I"$FP/gst-plugins-base$LI" -I"$FP/gst-plugins-bad$LI" -I"$FP/gstreamer$LI"\
             -I"${GRID}/openssl$LI" -I"$FP/glib$LI"  -I"$FP/dbus$LI" -L"${GRID}/openssl$LL" -L"$FP/glib$LL"  -L"$FP/dbus$LL"\
             -release -commercial -confirm-license -qt-pcre -force-debug-info -v -qt-xcb

}



qt_make1() {

 env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/dbus${LLP}:${FP}/gst-plugins-bad${LLP}:${FP}/gst-plugins-base${LLP}:${FP}/gstreamer${LLP}" \
 LD_LIBRARY_PATH="${FP}/gst-plugins-bad${LL}:${FP}/dbus${LL}:${FP}/dbus$LX:${FP}/dbus/latest/var/lib:${FP}/glib/${LL}:${FP}/gstreamer/${LL}:${FP}/gstreamer$LX:${FP}/gst-plugins-base${LL}"\
 make

}

###########################################################################################

qt_cnf2() {

    PK=/Qt/Qt-5.1.0
    prefix $PK   
 env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/dbus${LLP}" \
 LD_LIBRARY_PATH="${FP}/dbus${LL}:${FP}/dbus$LX:${FP}/dbus/latest/var/lib:${FP}/glib/${LL}"\
 ./configure -prefix "$PREFIX" \
             -I"${GRID}/openssl$LI" -I"$FP/glib$LI"  -I"$FP/dbus$LI" -L"${GRID}/openssl$LL" -L"$FP/glib$LL"  -L"$FP/dbus$LL"\
             -release -commercial -confirm-license -force-debug-info -v

}


qt_make2() {

 env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/dbus${LLP}" \
 LD_LIBRARY_PATH="${FP}/dbus${LL}:${FP}/dbus$LX:${FP}/dbus/latest/var/lib:${FP}/glib/${LL}"\
 make

}
 

gst_plugins_cnf() {
#gstreamer 

    ##D1=/gst-plugins-base-1.1.3
    D1=/gst-plugins-base-0.10.30
    P1=/gst-plugins-base
    PT=${FP}$P1$D1


    PK=/pkgs$P1$D1
    prefix $PK   

#  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#              nonstandard directory <lib dir>
#  LIBS        libraries to pass to the linker, e.g. -l<library>
#  CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
#              you have headers in a nonstandard directory <include dir>
#  CPP         C preprocessor
#  PKG_CONFIG  path to pkg-config utility


    ##env PATH="${PKGS}/pkgs/glib${LB}:${PATH}"  CPPFLAGS="-I$PKGS/pkgs/glib/latest/include" LDFLAGS="-L$PKGS/pkgs/glib/latest/lib" PKG_CONFIG="${GRID}/pkgconfig${LB}" ./configure --prefix $PREFIX 
     
    env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/gstreamer${LLP}" PATH="${FP}/glib${LB}:${PATH}"  CPPFLAGS="-I${FP}/glib/latest/include" LDFLAGS="-L${FP}/glib/latest/lib" ./configure --prefix $PREFIX 
}


gst_plugins_bad_cnf() {
#gstreamer 

set -xv

    #D1=/gst-plugins-bad-1.1.3
    D1=/gst-plugins-bad-0.10.17
    #D1=/gst-plugins-bad-1.0.3
    P1=/gst-plugins-bad
    PT=${FP}$P1$D1


    PK=/pkgs$P1$D1
    prefix $PK   

#  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#              nonstandard directory <lib dir>
#  LIBS        libraries to pass to the linker, e.g. -l<library>
#  CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
#              you have headers in a nonstandard directory <include dir>
#  CPP         C preprocessor
#  PKG_CONFIG  path to pkg-config utility


    ##env PATH="${PKGS}/pkgs/glib${LB}:${PATH}"  CPPFLAGS="-I$PKGS/pkgs/glib/latest/include" LDFLAGS="-L$PKGS/pkgs/glib/latest/lib" PKG_CONFIG="${GRID}/pkgconfig${LB}" ./configure --prefix $PREFIX 
     
    env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/gstreamer${LLP}:${FP}/gst-plugins-base${LLP}:${FP}/dbus${LLP}"\
        PATH="${FP}/glib${LB}:${PATH}"\
        CPPFLAGS="-I${FP}/glib$LI -I${FP}/gst-plugins-base${LI} -I${FP}/dbus${LI}"\
        LDFLAGS="-L${FP}/glib$LL -L${FP}/gst-plugins-base$LL -L${FP}/dbus$LL"\
        ./configure --prefix $PREFIX 


set +xv
}



gst_bad_cnf() {
#gstreamer 

    #D1=/gst-plugins-bad-1.1.3
    #D1=/gst-plugins-bad-0.10.17
    #D1=/gst-plugins-bad-0.10.12
    D1=/gst-plugins-bad-0.10.8
    #D1=/gst-plugins-bad-1.0.3
    P1=/gst-plugins-bad
    PT=${FP}$P1$D1


    PK=/pkgs$P1$D1
    prefix $PK   

#  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#              nonstandard directory <lib dir>
#  LIBS        libraries to pass to the linker, e.g. -l<library>
#  CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
#              you have headers in a nonstandard directory <include dir>
#  CPP         C preprocessor
#  PKG_CONFIG  path to pkg-config utility

     
#    env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/gstreamer${LLP}:${FP}/gst-plugins-base${LLP}:${FP}/dbus${LLP}"\
#        PATH="${FP}/glib${LB}:${PATH}"\
#        CPPFLAGS="-I${FP}/glib$LI -I${FP}/gst-plugins-base${LI} -I${FP}/dbus${LI}"\
#        LDFLAGS="-L${FP}/glib$LL -L${FP}/gst-plugins-base$LL -L${FP}/dbus$LL"\
#        ./configure --prefix $PREFIX 

   env PKG_CONFIG_PATH="${FP}/glib${LLP}:${FP}/dbus${LLP}"\
        PATH="${FP}/glib${LB}:${PATH}"\
        CPPFLAGS="-I${FP}/glib$LI -I${FP}/dbus${LI}"\
        LDFLAGS="-L${FP}/glib$LL  -L${FP}/dbus$LL"\
        ./configure --prefix $PREFIX 
}

gst_cnf() {
#gstreamer 

    ##PK=/pkgs/gstreamer/gstreamer-1.1.3
    PK=/pkgs/gstreamer/gstreamer-0.10.30
    prefix $PK   

#  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#              nonstandard directory <lib dir>
#  LIBS        libraries to pass to the linker, e.g. -l<library>
#  CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
#              you have headers in a nonstandard directory <include dir>
#  CPP         C preprocessor
#  PKG_CONFIG  path to pkg-config utility



    ##env PATH="${PKGS}/pkgs/glib${LB}:${PATH}"  CPPFLAGS="-I$PKGS/pkgs/glib/latest/include" LDFLAGS="-L$PKGS/pkgs/glib/latest/lib" PKG_CONFIG="${GRID}/pkgconfig${LB}" ./configure --prefix $PREFIX 
     
    env PKG_CONFIG_PATH="${FP}/glib/latest/lib/pkgconfig" PATH=${GRID}/flex${LB}:"${FP}/glib${LB}:${PATH}"  CPPFLAGS="-I${FP}/glib/latest/include -I/usr/lib64/qt4/include/QtCore -I${QTDIR}/include" LDFLAGS="-L${FP}/glib/latest/lib" ./configure --prefix $PREFIX 

}

automake_cnf() {

    PK=/pkgs/automake/automake-1.13.2
    prefix $PK   


    env PATH=${GRID}/autoconf${LB}/:${PATH} ./configure --prefix $PREFIX
}

dbus_cnf() {

    PK=/pkgs/dbus/dbus-1.6.12
    prefix $PK   


##    env PATH=${GRID}/autoconf${LB}/:${PATH} ./configure --prefix $PREFIX
    env PATH=${GRID}/autoconf${LB}/:${PATH} ./configure --prefix $PREFIX
}

xcbutil() {

##      CFLAGS="-std=c99" \
##      CPPFLAGS="-DO_CLOEXEC=0 -D__SIZEOF_POINTER__=8" \
##      CPPFLAGS="-DO_CLOEXEC=0${CPPFLAGS}" \

##        ACLOCAL="aclocal -I ${GRID}/gettext${LS}/aclocal -I ${FP}/libtool${LS}/aclocal -I ${GRID}/automake${LS}/aclocal-1.11 -I ${GRID}/automake${LS}/automake-1.11 -I ${FP}/xorgmacros${LS}/aclocal -I /usr/share/aclocal" \
        local XCB_LIBS="${XCB_PATH}${XCB_BUILD}/lib:${XCB_PATH}${XCB_BUILD}/lib/X11/xdm:${XCB_PATH}${XCB_BUILD}/lib/dri:${XCB_PATH}${XCB_BUILD}/lib/xorg/modules/drivers:${XCB_PATH}${XCB_BUILD}/lib/xorg/modules/input"



    env PYTHON2="${PYPATH}/bin/python" \
        PYTHONPATH="${FP}/libxml2-python/latest/lib/python2.7/site-packages:${PYTHONPATH}" \
        LD_LIBRARY_PATH="${GRID}/freetype${LL}:${FP}/xmlto${LL}:${GRID}/libxml${LL}:${PYPATH}/lib:${XCB_LIBS}:${LD_LIBRARY_PATH}" \
        GITROOT="http://anongit.freedesktop.org/git" \
        SED="${GRID}/sed${LB}/sed" \
        LEX="${LEXPATH}/flex" \
        PKG_CONFIG="${GRID}/pkgconfig${LB}/pkg-config" \
        PKG_CONFIG_PATH="${FP}/xcb-proto${LLP}:${FP}/mtdev${LLP}:${FP}/glib${LLP}:${FP}/dbus${LLP}:${FP}/dri2proto${LLP}:${FP}/libdrm${LLP}:${FP}/pthread-stubs${LLP}:${FP}/glproto${LLP}:${PYPATH}/lib/pkgconfig:${GRID}/libxml${LLP}:${FP}/xorgmacros${LS}/pkgconfig:${GRID}/freetype${LLP}:${GRID}/fontconfig${LLP}:${FP}/libffi${LLP}:/usr/lib64/pkgconfig:${FP}/pixman${LLP}" \
        PATH=${GRID}/intltool${LB}:${GCC1}:${LEXPATH}:${GRID}/llvm${LB}:${FP}/libtool${LB}:${AUTOTOOLS}:${GRID}/gettext${LB}:${FP}/xmlto${LB}:${FP}/python2${LB}:${PYPATH}/bin:${GRID}/git${LB}:${PATH} \
        \
        "$@"
}


##PATH=${GCC1}:${LEXPATH}:${GRID}/llvm${LB}:${FP}/libtool${LB}:${AUTOTOOLS}:${GRID}/gettext${LB}:${FP}/xmlto${LB}:${FP}/python2${LB}:${PYPATH}/bin:${GRID}/git${LB}:${PATH} \

xcb() {

##${XCB_PATH}/util/modular/build.sh -p  --retry-v1 --check --clone ${XCB_PATH}${XCB_BUILD} -g "$@"  \
    killall tail

    mkdir -p ${XCB_PATH}
    pushd ${XCB_PATH}

    xcbutil \
    \
    ${XCB_PATH}/util/modular/build.sh -p   --clone ${XCB_PATH}${XCB_BUILD} -g "$@"  \
>& ${XCB_PATH}/xcb_log11 &
    tail -F ${XCB_PATH}/xcb_log11 &
}

xcbloop() {

    killall tail

    tail -F ${XCB_PATH}/xcb_log11 &


    for i in {1..10} ; do

        cd  ${XCB_PATH}
        echo "============================= XCBLOOP BEGIN  N$i  `date`===================================== " > ${XCB_PATH}/xcb_log11

    xcbutil \
    \
    ${XCB_PATH}/util/modular/build.sh -p -n --clone ${XCB_PATH}${XCB_BUILD} -g >> ${XCB_PATH}/xcb_log11 2>&1


        echo "============================= XCBLOOP END    N$i  `date`===================================== " >> ${XCB_PATH}/xcb_log11
        
        ( cd /export/home/<USER>/downloads ; ${GRID}/git${LB}/git commit -am "autocommit xcbloop N$i `date` "  )
    done
}

xcbsync() {

#    killall tail

    xcbutil ${XCB_PATH}/util/modular/build.sh --retry-v1 --check --clone ${XCB_PATH}${XCB_BUILD} -g  "$@" 
}

xcbsync1() {

#    killall tail

    xcbutil ${XCB_PATH}/util/modular/build.sh  --clone ${XCB_PATH}${XCB_BUILD} -g  "$@" 
}

xcbpure() {

    killall tail

    xcbutil \
    \
    ${XCB_PATH}/util/modular/build.sh ${XCB_PATH}${XCB_BUILD} -g "$@"  \
>& xcb_log11 &
    tail -F xcb_log11 &
}

xcb_make() {

    env GITROOT="http://anongit.freedesktop.org/git" \
        SED="${GRID}/sed${LB}/sed" \
        PKG_CONFIG="${GRID}/pkgconfig${LB}/pkg-config" \
        ACLOCAL="aclocal -I ${GRID}/automake${LS}/aclocal-1.11 -I ${GRID}/automake${LS}/automake-1.11  -I /usr/share/aclocal" \
            PATH=${GRID}/libtool${LB}:${AUTOTOOLS}:${GRID}/gettext${LB}:${FP}/xmlto${LB}:${GRID}/python${LB}:${GRID}/git${LB}:${PATH} \
        \
        make $@
}

xcb_init() {
    killall tail

    mkdir -p ${XCB_PATH}
    pushd ${XCB_PATH}
    ls -1 ${XCB_PATH} | grep -v cnf | xargs rm -frv
    ln -s ~/scripts/tmp/cnf.sh ./cnf
    mkdir -p ${XCB_PATH}${XCB_BUILD}
    env PATH=${GRID}/git${LB}:${PATH} git clone http://anongit.freedesktop.org/git/xorg/util/modular util/modular
    popd
}

xcb_autogen() {

    env GITROOT="http://anongit.freedesktop.org/git" \
        SED="${GRID}/sed${LB}/sed" \
        PKG_CONFIG="${GRID}/pkgconfig${LB}/pkg-config" \
        ACLOCAL="aclocal -I ${GRID}/automake${LS}/aclocal-1.11 -I ${GRID}/automake${LS}/automake-1.11  -I /usr/share/aclocal" \
            PATH=${GRID}/libtool${LB}:${AUTOTOOLS}:${GRID}/gettext${LB}:${FP}/xmlto${LB}:${GRID}/python${LB}:${GRID}/git${LB}:${PATH} \
        \
        ./autogen.sh
}


xmlto() {

    PK=/pkgs/xmlto/xmlto-0.0.25
    prefix $PK   


    env PATH=${GRID}/autoconf${LB}/:${PATH} ./configure --prefix $PREFIX
}

libtool() {
    ##PK=/pkgs/libtool/libtool-2.4.2
    ##PK=/pkgs/libtool/libtool-1.5.6
    PK=/pkgs/libtool/libtool-1.5.8
    prefix $PK   


    env PATH=${AUTOTOOLS}:${PATH} ./configure --prefix $PREFIX
}

autoconf() {
    ##PK=/pkgs/libtool/libtool-2.4.2
    ##PK=/pkgs/libtool/libtool-1.5.6
    PK=/pkgs/autoconf/autoconf-2.69
    prefix $PK   


    ./configure --prefix $PREFIX
}



util() {
    env SED="${GRID}/sed${LB}/sed" \
        PKG_CONFIG="${GRID}/pkgconfig${LB}/pkg-config" \
        PATH=${GRID}/libtool${LB}:${AUTOTOOLS}:${GRID}/gettext${LB}:${FP}/xmlto${LB}:${GRID}/python${LB}:${GRID}/git${LB}:${PATH} \
        \
        $@
}



xorgmacros() {

    PK=/pkgs/xorgmacros/xorgmacros
    prefix $PK   


    util ./configure --prefix $PREFIX
}


xorgserver() {

    PK=/pkgs/xorg-server/xorg-server-1.14.2
    prefix $PK   


    xcbutil ./configure --prefix $PREFIX
}

pixman() {

    PK=/pkgs/pixman/pixman-0.30.2
    prefix $PK   


    xcbutil ./configure --prefix $PREFIX
}

glproto() {

    PK=/pkgs/glproto/glproto-1.4.16
    prefix $PK   


    xcbutil ./configure --prefix $PREFIX
}

mesa() {

    PK=/pkgs/Mesa/Mesa-9.1.6
    prefix $PK   


    xcbutil ./configure --prefix $PREFIX
}

libdrm() {

    PK=/pkgs/libdrm/libdrm-2.4.46
    prefix $PK   


    xcbutil ./configure --prefix $PREFIX
}

pstubs() {

    PK=/pkgs/pthread-stubs/pthread-stubs-0.3
    prefix $PK   


    xcbutil ./configure --prefix $PREFIX
}

dri2proto() {

    PK=/pkgs/dri2proto/dri2proto-2.8
    prefix $PK   


    xcbutil ./configure --prefix $PREFIX
}

abcdef() {
    echo "HELLO FROM ABCDEF"
}

# make | install
xmlpy() {

    xcbutil python2 setup.py $@ >& xmlpy.log
}

xmlpyinstall() {

    PK=/pkgs/libxml2-python/libxml2-python-2.6.9
    prefix $PK

    xcbutil python2 setup.py install --prefix $PREFIX $@
}

systemd() {

    GCC1=${GRID}/gcc${LB}
    PK=/pkgs/systemd/systemd-206
    prefix $PK   


    xcbutil which gcc
    xcbutil ./configure --prefix $PREFIX
}

mtdev() {

    GCC1=${GRID}/gcc${LB}
    PK=/pkgs/mtdev/mtdev-1.0.6
    prefix $PK   

    xcbutil which gcc
    xcbutil ./configure --prefix $PREFIX --disable-static
}

xcbsnpt() {

    CPPFLAGS=" -I${FP}/mtdev/${LI}"

    xcb -p -o "driver/xf86-input-synaptics"
}

libxcb() {

    GCC1=${GRID}/gcc${LB}
    PK=/pkgs/libxcb/libxcb-1.9
    prefix $PK   

    xcbutil which gcc
    xcbutil ./configure --prefix $PREFIX 
}

xcbproto() {

    GCC1=${GRID}/gcc${LB}
    PK=/pkgs/xcb-proto/xcb-proto-1.8
    prefix $PK   

    xcbutil which gcc
    xcbutil ./configure --prefix $PREFIX 
}

haskell() {

    ##PK=/pkgs/haskell-platform/haskell-platform-2013.2.0.0
    PK=/pkgs/haskell-platform/haskell-platform-2011.2.0.0
    prefix $PK   

    qtutil which gcc
    PATH=${FP}/ghc${LB}:${PATH}
    qtutil ./configure --prefix $PREFIX 
}

ghc() {

    ##PK=/pkgs/ghc/ghc-7.6.3
    ##PK=/pkgs/ghc/ghc-6.4.1
    ##PK=/pkgs/ghc/ghc-7.0.4
    PK=/pkgs/ghc/ghc-7.0.2
    prefix $PK   

    qtutil which gcc
    qtutil ./configure --prefix $PREFIX 
}

##qt_make
##qt_cnf
#dbus_cnf
##gst_plugins_cnf
##gst_cnf
#glib_cnf
##automake_cnf
##glib_make

"$@"


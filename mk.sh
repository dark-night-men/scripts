#!/bin/bash

##qtver=5.2_1
qtver=5.2.1_1
QTDIR=/usr/local/Qt/"$qtver"


make() {
    env PATH=${QTDIR}/bin:${PATH}\
        LD_LIBRARY_PATH=${QTDIR}/lib:${LD_LIBRARY_PATH}\
        LIBS=-ldl\
        "$@"
}

make "$@"

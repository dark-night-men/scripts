#!/bin/csh
##alias oa64 'env LD_LIBRARY_PATH=`env BITS=64 sh -c echo\ \${LD_LIBRARY_PATH}:/usr/X11R6/lib64:${OA_LIB_PATH}`'
##alias pvsgmake64j 'oa64 nice \/grid/common/bin/gmake -j OPT=dbg TCL_COMPILE=no 64BIT=yes PARALLEL=4 ICFB_6_1_0=$CXV6  ICFB_5_0_0=$CXV5'

##setenv DDIR "libguireport"
##cd "$P4DIR/pvs/src/$DDIR/src"

##echo "$1"

/grid/common/bin/gmake -j OPT=dbg TCL_COMPILE=no 64BIT=yes ICFB_6_1_0="$CXV6"  ICFB_5_0_0="$CXV5"


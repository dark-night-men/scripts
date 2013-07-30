###set echo

set sys=lnx86
if ( ${OSTYPE} == solaris ) then
   set sys=sun4v
endif

##setenv LM_LICENSE_FILE  "5280@mos-lic1:5280@mos-lic2:27009@mospvs1:5280@sjflex1:5280@sjflex2:5280@sjflex3"
##setenv CDS_LIC_FILE     "5280@mos-lic1:5280@mos-lic2:5280@sjflex1:5280@sjflex2:5280@sjflex3"

##setenv LM_LICENSE_FILE  "5280@sjflex1:5280@sjflex2:5280@sjflex3"
setenv LM_LICENSE_FILE  "5280@mos-lic1:5280@mos-lic2:5280@sjflex1:5280@iss"
setenv CDS_LIC_FILE     ${LM_LICENSE_FILE:q}

setenv CDS_Netlisting_Mode Analog
setenv DESIGN_TECH_PATH /lan/avt/qpv_designdata/legacyLinks

if ( ${?CTDIR_INIT} ) then
    setenv CTDIR "${CTDIR_INIT}"
else

##----------------------------------------------------------------------
        ##setenv CTDIR /net/msc156/export/home/agibalov/work/snapshots/agibalov_pvs1210HF1_V01  ##GDS golden corrupt
        ##setenv CTDIR /net/msc156/export/home/agibalov/work/snapshots/agibalov_pvs1210HF1_V02  ##GDS golden
        
        ##setenv CTDIR /net/msc156/export/home/agibalov/work/snapshots/agibalov_pvs1211HF1_V01 ##verilog
        ##setenv CTDIR /net/msc156/export/home/agibalov/work/snapshots/agibalov_pvs1211HF1_V02  ##GDS golden

        ##setenv CTDIR /net/msc156/export/home/agibalov/work/snapshots/agibalov_pvs1211HF1_V03  ##GDS golden

        ##setenv CTDIR /net/msc156/export/home/agibalov/work/snapshots/agibalov_pvs1211HF1_V04 ##verilog updated
        ##setenv CTDIR /net/msc156/export/home/agibalov/work/snapshots/agibalov_pvs1211HF1_V05 ##-gds options size
endif

##setenv GIT_DIR ${CTDIR}/vobs/pvs_dev/src/.git/ 

##set ICFB_6_1_0=/grid/cic/products/dfII/IC6.1.4-64b/${sys}/pink/
##set ICFB_5_0_0=/grid/cic/products/dfII/5.10.41_ISR-64b/${sys}/pink/


##setenv VERSION  `masco -v | grep Version | awk '{print $3}'`


setenv PVS_DRCDE_SETAREA          YES
setenv PVS_DRCDE_DEBUG            YES
setenv PVS_DRCDE_BUTTON_PENDING   YES
setenv PVS_DRCDE_WAIVER_TOLERANCE YES
setenv PVS_DPLUI                  YES
setenv JPVS_RECENT_RUNS 	TRUE

###setenv jroot /net/msc089/export/home/CVS


setenv PVS_DRCDE_DEBUG t
setenv JPVS TRUE
setenv PVS_IPVS_DEBUG TRUE
#setenv PVSUI_SHOW_CONFIG_APPLY_BUTTON TRUE


setenv EDITOR vim

setenv NEDIT_HOME $HOME/.nedit
set path = ( /grid/common/pkgs/nedit/v5.5/bin ${path:q} )
umask 022




#setenv CVSROOT /net/mos128/export/home/myudashk/CVS


set OA_PATH="/grid/dfm/oa/latest"
set OAHOME="/grid/dfm/oa/22.43-p003"

switch ( `uname -s` )
case "Linux":
    set OA_LIB_PATH="${OA_PATH}/lib/linux_rhel30_"'${BITS}'"/opt"
    breaksw
case "SunOS":
    if ( `uname -r` != '5.10' ) then
        set OA_LIB_PATH="${OA_PATH}/lib/sunos_58_"'${BITS}'"/opt"
    else
        set OA_LIB_PATH="${OA_PATH}/lib/sunos_510_x86_"'${BITS}'"/opt"
    endif
    breaksw
case "AIX":
    set OA_LIB_PATH="${OA_PATH}/lib/aix_51_"'${BITS}'"/opt"
    breaksw
endsw



##setenv VERSION  `masco -v | grep Version | awk '{print $3}'`


setenv PVS_DRCDE_DEBUG t
setenv JPVS TRUE
setenv PVS_IPVS_DEBUG TRUE
setenv PVS_DEBUG_KEY '20130325-22001231:cadence.com:198d6822'
setenv PVS_DEBUG './pvsguidebug.log'
##setenv PVS_IPVS_GUI ENABLE

###setenv jroot /net/msc089/export/home/CVS

if ( ${?P4DIR_INIT} ) then
    setenv P4DIR "${P4DIR_INIT}"
else


    ##setenv P4DIR /lan/dfm/pvsp4_t1_v1/ws/agibalov/agibalov_pvs1211HF1_W1
    ##setenv P4DIR /net/msc156/export/home/agibalov/work/depots/agibalov_pvs1211HF2_W2

    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF2_W3   ## broken?  
    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF2_W4   ## to destroy ## destroyed

    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF2_W5   ## layout completed

    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF2_W6   ##  report

    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF2_W7   ## layout in progress
    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF2_W8   ## current

    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF3_W1   ## invalid to  delete
    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF3_W2   ## invalid to  delete

    ##setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF3_W3   ## 
    setenv P4DIR /net/msc156/export/home/agibalov/work/wspaces/agibalov_pvs1211HF3_W4   ## 
endif


##====================================================================================
setenv TSDIR "${P4DIR}"/pvs/src/pvs_QuickTest/test
setenv P4SYS ${P4DIR}/pvs/output/cdn_hier/${sys}
setenv P4QTDIR "${P4DIR}"/pvs/output/dep/${sys}_64/tools.${sys}/Qt/64bit


setenv PATH ${P4QTDIR}/bin/:${P4SYS}/bin:${P4SYS}/tools.${sys}/bin/64bit:${P4SYS}/tools.${sys}/bin:${P4SYS}/share/oa/bin:/sbin:/usr/X11R6/bin:/usr/bin:/bin
setenv LD_LIBRARY_PATH ${P4QTDIR}/lib:${P4SYS}/share/oa/lib/linux_rhel50_gcc44x_64/opt:${P4SYS}/tools.${sys}/lib/64bit:${P4SYS}/tools.${sys}/lib:${P4SYS}/tools.${sys}/Qt/64bit/lib:/usr/lib64:/usr/lib:/lib64:/lib


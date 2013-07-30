
if ( "$?CTDIR" ) then

##echo ~/scripts/set_ld_lib_linux86x64.csh CLEARCASE IS ON

##setenv LD_LIBRARY_PATH $PVLDIR/output/tarkits/linux86_32/gcc412p2/dbg/cdsQTDev/QT/lib:$LD_LIBRARY_PATH
##setenv LD_LIBRARY_PATH $PVLDIR/output/tarkits/linux86_32/gcc412p2/opt/cdsQTDev/QT/lib:$LD_LIBRARY_PATH
##setenv LD_LIBRARY_PATH $PVLDIR/output/tarkits/linuxopt_64/gcc412p2/dbg/cdsQTDev/QT/lib/64bit:$LD_LIBRARY_PATH
##setenv LD_LIBRARY_PATH $PVLDIR/output/tarkits/linuxopt_64/gcc412p2/opt/cdsQTDev/QT/lib/64bit:$LD_LIBRARY_PATH

foreach p (\
	$DV_VOBROOT/pvs_dev/output/tarkits/linux86_32/gcc412p2/dbg/cdsQTDev/QT/lib \
	$DV_VOBROOT/pvs_dev/output/tarkits/linux86_32/gcc412p2/opt/cdsQTDev/QT/lib \
	$DV_VOBROOT/pvs_dev/output/tarkits/linuxopt_64/gcc412p2/dbg/cdsQTDev/QT/lib/64bit \
	$DV_VOBROOT/pvs_dev/output/tarkits/linuxopt_64/gcc412p2/opt/cdsQTDev/QT/lib/64bit  \
	###$DV_VOBROOT/pvs_dev/output/cdn_hier/lnx86/tools.lnx86/lib/64bit \
)


    if ( -d $p:q && -r $p:q ) then
       setenv LD_LIBRARY_PATH ${p:q}:${LD_LIBRARY_PATH:q}
    endif
end

else
##echo ~/scripts/set_ld_lib_linux86x64.csh CLEARCASE IS OFF
endif

if ( "$?P4DIR" ) then

##echo ~/scripts/set_ld_lib_linux86x64.csh PERFORCE IS ON

foreach p ( \
        ${P4DIR}/pvs/output/tarkits/linux86_32/gcc412p2/dbg/cdsQTDev/QT/lib \
	${P4DIR}/pvs/output/tarkits/linux86_32/gcc412p2/opt/cdsQTDev/QT/lib \
	${P4DIR}/pvs/output/tarkits/linuxopt_64/gcc412p2/dbg/cdsQTDev/QT/lib/64bit \
	${P4DIR}/pvs/output/tarkits/linuxopt_64/gcc412p2/opt/cdsQTDev/QT/lib/64bit \
)

    if ( -d $p:q && -r $p:q ) then
       setenv LD_LIBRARY_PATH ${p:q}:${LD_LIBRARY_PATH:q}
    endif
end

else
##echo ~/scripts/set_ld_lib_linux86x64.csh PERFORCE IS OFF
endif


##setenv LD_LIBRARY_PATH ${OA_PATH}/lib/linux_rhel30_gcc411_32/opt:${LD_LIBRARY_PATH}
##setenv LD_LIBRARY_PATH ${OA_PATH}/lib/linux_rhel30_gcc411_64/opt:${LD_LIBRARY_PATH}


setenv LD_LIBRARY_PATH ${OA_PATH}/lib/linux_rhel40_gcc44x_32/dbg:${LD_LIBRARY_PATH}
setenv LD_LIBRARY_PATH ${OA_PATH}/lib/linux_rhel40_gcc44x_64/dbg:${LD_LIBRARY_PATH}

setenv LD_LIBRARY_PATH /sev/grp_mos_cm01/build_components/tarkits/ems64b/lnx86/31.09-p004/tools.lnx86/lib/64bit:${LD_LIBRARY_PATH}
setenv LD_LIBRARY_PATH /lib64/:${LD_LIBRARY_PATH}
setenv LD_LIBRARY_PATH /net/msc156/export/home/agibalov/tools/glperf/lib/:${LD_LIBRARY_PATH}

#setenv LD_LIBRARY_PATH ${CTDIR}/vobs/pvs_dev/output/cdn_hier/lnx86/tools.lnx86/Qt/64bit/lib:${LD_LIBRARY_PATH}
#setenv LD_LIBRARY_PATH ${CTDIR}/vobs/pvs_dev/output/cdn_hier/lnx86/tools.lnx86/lib:${LD_LIBRARY_PATH}
#setenv LD_LIBRARY_PATH ${CTDIR}/vobs/pvs_dev/output/cdn_hier/lnx86/tools.lnx86/lib/64bit:${LD_LIBRARY_PATH}
#setenv LD_LIBRARY_PATH ${CTDIR}/vobs/pvs_dev/output/cdn_hier/lnx86/tools.lnx86/lib/64bit/SuSE/SLES11:${LD_LIBRARY_PATH}


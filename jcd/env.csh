if ( ${sys} == "lnx86" ) then
	setenv bindir "linuxopt_64"
else
	setenv bindir "sol86_64"
endif
 
if ( "${?CTDIR}" ) then

##echo ~/scripts/env.csh CLEARCASE IS ON

setenv DV_VOBROOT ${CTDIR}/vobs/ 
setenv DV_PROJ_NFS_TIME_OUT 60 
setenv DV_SITE_DEPDIR /net/cds122/testImage 
setenv DV_SITE ms 
setenv DV_SITE_SERVER cds122 
setenv DV_SITE_INSTALL NA 
setenv CDS_LIC_FILE 5280@mos-lic1:5280@mos-lic2 
setenv DV_PROJ_DIR /dv/project/dev/pvs 
setenv DV_PROJ_INDEP_DIR /dv/share/project/dev/pvs 
setenv DV_PROJ_NAME dev 
setenv DV_PROJ_VARIANT pvs 
setenv DV_PROJ_CNF ${DV_VOBROOT}/dvproject/conf/project.cnf 
setenv CLEARCASE_AVOBS /vobs/dvproject:/vobs/pvs_dev 
setenv CDS_ROOT ${DV_VOBROOT}/dvproject/dep 


setenv LD_LIBRARY_PATH ${DV_VOBROOT}/pvs_dev/output/tarkits/${bindir}/gcc443p1/dbg/cdsQTDev/Qt/64bit/lib:${LD_LIBRARY_PATH} 
setenv LD_LIBRARY_PATH ${DV_VOBROOT}/pvs_dev/output/tarkits/${bindir}/gcc443p1/opt/cdsQTDev/Qt/64bit/lib:${LD_LIBRARY_PATH} 
setenv PATH ${DV_VOBROOT}/pvs_dev/output/cdn_hier/${sys}/bin:${PATH} 
 
#setenv LD_LIBRARY_PATH `echo ":${LD_LIBRARY_PATH}:" | \ 
#sed -e 's@:[^:]*/cdsQTDev/Qt/[^:]*:@:@g' \ 
#        -e "s@^@${DV_VOBROOT}/pvs_dev/output/tarkits/linuxopt_64/gcc443p1/opt/cdsQTDev/Qt/64bit/lib@" \ 
#        -e 's@:$@@'` 
#setenv PATH `echo ":${PATH}:" | \ 
#    sed -e 's@:[^:]*/output/cdn_hier/[^:]*:@:@g' \ 
#        -e "s@^@${DV_VOBROOT}/pvs_dev/output/cdn_hier/lnx86/bin@" \ 
#        -e 's@:$@@'` 
rehash 

else

##echo ~/scripts/env.csh CLEARCASE IS OFF

endif

########################################################################

##PERFORCE
if ( "$?P4DIR" ) then

##echo ~/scripts/env.csh PERFORCE IS ON

setenv LD_LIBRARY_PATH ${P4DIR}/pvs/output/tarkits/${bindir}/gcc443p1/dbg/cdsQTDev/Qt/64bit/lib:${LD_LIBRARY_PATH} 
setenv LD_LIBRARY_PATH ${P4DIR}/pvs/output/tarkits/${bindir}/gcc443p1/opt/cdsQTDev/Qt/64bit/lib:${LD_LIBRARY_PATH} 
setenv PATH ${P4DIR}/pvs/output/cdn_hier/${sys}/bin:${PATH} 
 

else
##echo ~/scripts/env.csh PERFORCE IS OFF
endif


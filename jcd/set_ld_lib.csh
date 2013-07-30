set platf = "`uname -srp`";

source ~/scripts/env.csh


setenv LD_LIBRARY_PATH_MAIN
setenv PKG_CONFIG_PATH

switch("${platf}")

    case Linux*:
        set sys=lnx86

        ##setenv LD_LIBRARY_PATH_MAIN /usr/local/lib:/usr/lib


        switch("${platf}")

            case *i686:
		setenv platform linux86
                foreach p ( /usr/evolution28/lib64 /lib /usr/lib /usr/X11R6/lib /grid/common/pkgsData/gcc-v4.1.2p2/Linux/RHEL4.0-2007-x86/lib /grid/common/pkgsData/gcc-v4.1.2p2/Linux/RHEL5.0-2008-x86/lib )
                    if ( -d $p:q && -r $p:q ) then
                        setenv LD_LIBRARY_PATH ${p:q}:${LD_LIBRARY_PATH:q}
                    endif
                end
                breaksw
            case *x86_64
		setenv platform linuxopt
##                foreach p ( /lib64 /usr/lib64 /usr/X11R6/lib64 /grid/common/pkgsData/gcc-v4.1.2p2/Linux/RHEL4.0-2007-x86_64/lib64 /grid/common/pkgsData/gcc-v4.1.2p2/Linux/RHEL5.0-2008-x86_64/lib64 )
                foreach p ( /lib64 /usr/lib64 /usr/X11R6/lib64 /grid/common/pkgsData/gcc-v4.4.4/Linux/RHEL5.0-2010-x86_64/lib64 )
                    if ( -d $p:q && -r $p:q ) then
                        setenv LD_LIBRARY_PATH ${p:q}:${LD_LIBRARY_PATH:q}
                    endif
                end
                ##setenv LD_LIBRARY_PATH_MAIN /usr/local/lib64:/usr/local/lib:/usr/local/X11R6/lib:/usr/local/gcc-3.2/lib:/usr/lib64:/usr/lib:/lib64:/usr/local/KDE/lib:/usr/local/qt/lib:/usr/openwin/lib:$LD_LIBRARY_PATH

                setenv CDS_AUTO_64BIT ALL
                breaksw

            case *2.4.21*:
                ##setenv LD_LIBRARY_PATH_MAIN /grid/common/pkgsData/gcc-v4.1.2p1/Linux/RHEL4.0-1H2006-x86/lib:/usr/local/lib:/usr/local/X11R6/lib:/usr/local/gcc-3.2/lib:/usr/lib:/usr/openwin/lib:$LD_LIBRARY_PATH            
                

                foreach p ( /grid/common/pkgsData/gcc-v4.1.2p1/Linux/RHEL4.0-1H2006-x86/lib /usr/local/lib /usr/local/X11R6/lib /usr/local/gcc-3.2/lib /usr/lib /usr/openwin/lib )
                    if ( -d $p:q && -r $p:q ) then
                        setenv LD_LIBRARY_PATH ${p:q}:${LD_LIBRARY_PATH:q}
                    endif
                end                               
                       
                set path = ( $path )
                breaksw

            case *2.4.*:
                breaksw

        endsw

	source ~/scripts/set_ld_lib_linux86x64.csh

        breaksw

    case SunOS*5.*:

#	set lplatf = "`uname -a`";
#	switch( "${lplatf}" )
#	case *sun4u*:
#		set sys=sun4u
#	breaksw
#	case *sun4v*:
#		set sys=sun4v
#	breaksw
#	endsw

#        set sys=sun4v
	set sys=sol86
	setenv platform SunOS
        alias mc 'mc -ab'
        setenv COLORTERM linux
        setenv MC_COLOR_TABLE normal=white,black
        setenv OPENWINHOME /usr/openwin
        setenv QTDIR /usr/local/qt

        #Proper gcc
        if (-f /usr/local/gccs/cshrc.gcc2.95) then
            source /usr/local/gccs/cshrc.gcc2.95
        endif
        set MANPATH=(/usr/local/X11R6/man /usr/local/man $OPENWINHOME/man \
                     $OPENWINHOME/share/man /usr/man /usr/dt/man        \
                     /usr/local/KDE/man)
                                 
        ##setenv LD_LIBRARY_PATH_MAIN /usr/local/lib:/usr/local/X11R6/lib:/usr/lib:/usr/local/KDE/lib:/usr/local/qt/lib:/usr/openwin/lib:/usr/local/gcc-3.2/lib        
        foreach p ( /usr/local/lib /usr/local/X11R6/lib /usr/lib /usr/local/KDE/lib /usr/local/qt/lib /usr/openwin/lib /usr/local/gcc-3.2/lib )
            if ( -d $p:q && -r $p:q ) then
               setenv LD_LIBRARY_PATH ${p:q}:${LD_LIBRARY_PATH:q}
            endif
        end        
        
        

        ##set path=( /usr/local/bin /opt/SUNWspro/bin \
        ##         /usr/local/KDE/bin $QTDIR/bin /usr/ccs/bin /usr/dt/bin /bin /usr/bin       \
        ##         /usr/ucb /opt/Acrobat4/bin /etc $OPENWINHOME/bin /opt/SUNWns6         \
        ##         /net/mos060/opt/SUNWspro/bin )
                     
        foreach p ( /usr/local/bin /opt/SUNWspro/bin \
                 /usr/local/KDE/bin $QTDIR/bin /usr/ccs/bin /usr/dt/bin /bin /usr/bin       \
                 /usr/ucb /opt/Acrobat4/bin /etc $OPENWINHOME/bin /opt/SUNWns6         \
                 /net/mos060/opt/SUNWspro/bin )
                     
            if ( -d $p:q && -r $p:q ) then
               set path =( ${p:q} ${path:q} )
            endif
        end
            

        if ( $?prompt ) then
            set history=200
        endif


        #license server specification
        ##setenv LM_LICENSE_FILE 5280@mos-lic1:5280@mos-lic2:27009@mospvs1:5280@sjflex1:5280@sjflex2:5280@sjflex3
        #setenv CDS_LIC_FILE 5280@mos-lic1:5280@mos-lic2

	setenv LM_LICENSE_FILE  "5280@sjflex1:5280@sjflex2:5280@sjflex3"
	setenv CDS_LIC_FILE     $LM_LICENSE_FILE:q

        breaksw
endsw

###setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH_MAIN


##if ( "${OSTYPE}" == "linux" ) then
    ##ping -t 1 -r -W 2 -c 1 msc094.cadence.com >& /dev/null
    ##if ( $status == 0) then
        ##setenv LD_LIBRARY_PATH /lan/avt/pkgs/lib:$LD_LIBRARY_PATH
        ##set path=( /lan/avt/pkgs/bin $path )
        ##rehash
    ##endif
##endif


set OA_PATH="/grid/dfm/oa/latest"

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


if ( "${?CTDIR}" ) then

foreach p ( \
            ${DV_VOBROOT}/vobs/pvs_dev/output/tarkits/linuxopt_64/gcc443p1/dbg/cdsQTDev/Qt/64bit/lib/ \
            ${DV_VOBROOT}/pvs_dev/output/cdn_hier/${sys}/bin \
            /grid/common/pkgs/perl/latest/bin \
##            /export/home/agibalov/local/pak/bin \
##            /grid/cic/products/dfII/5.10.41_USR5-64b/${sys}/pink/tools.${sys}/dfII/bin/ \
            /grid/cic/products/dfII/IC6.1.4-64b/${sys}/pink/tools.${sys}/dfII/bin/ \
 ) 
##	    /net/msc091/export/home/agibalov/local/tools/bin )
                     
    if ( -d $p:q && -r $p:q ) then
        set path =( ${p:q} ${path:q} )
    endif
end

endif

if ( "${?P4DIR}" ) then

foreach p ( \
            ${P4DIR}/pvs/output/tarkits/linuxopt_64/gcc443p1/dbg/cdsQTDev/Qt/64bit/lib/ \
            ${P4DIR}/pvs/output/cdn_hier/${sys}/bin \
            /grid/common/pkgs/perl/latest/bin \
            /grid/cic/products/dfII/IC6.1.4-64b/${sys}/pink/tools.${sys}/dfII/bin/ \
)
                     
    if ( -d $p:q && -r $p:q ) then
        set path =( ${p:q} ${path:q} )
    endif
end

endif


setenv PRODUCT  PVS

setenv LD_LIBRARY_PATH /lib64/:${LD_LIBRARY_PATH}

##setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH_MAIN}:${LD_LIBRARY_PATH}

foreach p ( `echo ${LD_LIBRARY_PATH_MAIN} | sed -re 's/:/ /g'` )
    if ( -d $p:q && -r $p:q ) then
       setenv LD_LIBRARY_PATH ${p:q}:${LD_LIBRARY_PATH:q}
    endif
end



#set IC5141_INSTALL_DIR = "/cic/dfII/IC6.2.0/lnx86/pink"
#set path =( ${IC5141_INSTALL_DIR}/tools/dfII/bin ${IC5141_INSTALL_DIR}/tools/bin ${path} )


rehash


setenv LD_LIBRARY_PATH /sev/grp_mos_cm01/build_components/tarkits/ems64b/lnx86/31.09-p004/tools.lnx86/lib/64bit:${LD_LIBRARY_PATH}

source ~/scripts/set_ld_lib_localhost.csh

setenv LD_TMP1 ${LD_LIBRARY_PATH}

unsetenv LD_LIBRARY_PATH
setenv LD_LIBRARY_PATH 
foreach pp ( `echo ${LD_TMP1} | sed -re 's/:/\n/g' | sort -ur` )
   setenv LD_LIBRARY_PATH ${pp}:${LD_LIBRARY_PATH}
end


rehash

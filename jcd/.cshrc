##set echo
set nobeep

if ( $OSTYPE == "solaris" ) then
/usr/openwin/bin/xset b 0
endif

set autolist
set color
set fignore = ".o"

set my_host = "msc091"
set curr_host = "`uname -n | sed 's/\..*//'`"

##setenv DISPLAY ${my_host}:0.0

set IPVS_FONTS_CONTROL = "YES"

setenv PAGER less

set dunique
set dextract

echo $path >& /tmp/ppath
set path=(  )
            
            
foreach p ( \
#    /usr/kerberos/bin \
#    /grid/cic/products/dfII/5.10.41_USR5-64b/lnx86/red/tools.lnx86/dfII/bin/ \
#    /vobs/pvs_dev/output/cdn_hier/lnx86/bin \
#    /grid/common/pkgs/perl/latest/bin \
#    /grid/common/pkgs/nedit/v5.5/bin \
#    /home/agibalov/bin \
    /bin \
    /usr/bin \
#    /usr/bin/X11 \
#    /usr/local/bin \
    /usr/X11R6/bin \
    /sbin \
#    /usr/games \
##    /grid/common/pkgs/pcrtools \
#    /usr/openwin/bin/ \
###    /grid/common/bin \
##     /grid/common/pkgsData/doxygen-v1.7.1/Linux/RHEL5.0-2010-x86_64/bin/ \
       /grid/common/pkgsData/graphviz-v2.24.0/Linux/RHEL5.0-2010-x86_64/bin/ \
       /grid/common/pkgsData/gv-v3.7.2/Linux/RHEL5.0-2010-x86_64/bin/ \
)

                     
    if ( -d $p:q && -r $p:q ) then
        set path =( ${p:q} ${path:q} )
    endif
end


unset have_term
if { stty >& /dev/null } then
   set have_term
endif

# Avoid stupid problems from 'which' on Solaris
# It sets an empty, but true prompt, which gets confusing
# since things only check to see if a prompt exists to tell
# whether they're interactive or not
if ( ${?prompt} ) then
   if( "$prompt" == "" ) then
      unset prompt
   endif
endif

if (! $?me) set me=~;

source ~/scripts/set_ssh.csh

# If we are not running tcsh and if it is in $path, then try to exec it:
if ((! ${?tcsh}) && ${?prompt} && ${?have_term}) then
        foreach trypath (${path} /bin /usr/local/bin )
                if ((-x ${trypath}/tcsh) && (-r ${trypath}/tcsh) && \
                (-f ${trypath}/tcsh) && (! -z ${trypath}/tcsh)) then
                        if { ${trypath}/tcsh -fc exit 0 } then
                                setenv tcsh tcsh
                                exec ${trypath}/tcsh
                        endif
                endif
        end
endif

unsetenv LD_LIBRARY_PATH
setenv LD_LIBRARY_PATH

if (! $?LD_LIBRARY_PATH) then
    setenv LD_LIBRARY_PATH /lib:/usr/lib
endif

if("${curr_host}" == "${my_host}") then
    set usr2_prefix="/export/home"
else
    set usr2_prefix="/net/${my_host}/export/home"
endif

set platf = "`uname -srp`";


source ~/scripts/set_env.csh

source ~/scripts/set_prompt.csh

source ~/scripts/set_ld_lib.csh

##cd ${CTDIR}
######## CLEARCASE
#source /grid/dfm/csvcm_v1/etc/.cshrc.dfm


setenv LD_LIBRARY_PATH /dv/project/dev/pvs/dep/tools.lnx86/lib/64bit/:${LD_LIBRARY_PATH}

######DEBUG start
##setenv LD_LIBRARY_PATH /net/msc156/export/home/agibalov/work/snapshots/agibalov_view1110_R02/vobs/pvs_dev/output/cdn_hier/lnx86/tools.lnx86/Qt/64bit/lib:${LD_LIBRARY_PATH}


####setenv PATH /dv/tools/bin:/usr/atria/bin:/dv/tools/rd/bin:/grid/cic/products/dfII/IC6.1.4-64b/lnx86/pink/tools.lnx86/dfII/bin/:/grid/common/pkgs/perl/latest/bin:/net/msc156/export/home/agibalov/work/snapshots/agibalov_pvs1110_GEN3/vobs/pvs_dev/output/cdn_hier/lnx86/bin/sbin/usr/X11R6/bin/usr/local/bin/usr/bin/bin/home/agibalov/bin/usr/kerberos/bin

######DEBUG stop

xhost + >& /dev/null
limit coredump unlimited



unsetenv OA_LIB_PATH
unsetenv OA_PATH

##setenv CPUPROFILE /tmp/profile; ${CTDIR}/vobs/pvs_dev/output/cdn_hier/lnx86/tools.lnx86/pvs/bin/64bit/ipvs
##setenv LD_PRELOAD "/net/msc156/export/home/agibalov/tools/glperf/lib/libprofiler.so"

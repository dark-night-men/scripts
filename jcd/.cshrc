##set echo

if ( $OSTYPE == "solaris" ) then
/usr/openwin/bin/xset b 0
endif


set filec
set autolist
set addsuffix 
set color


setenv PAGER less
set dunique
set dextract



unset have_term
if { stty >& /dev/null } then
   set have_term
endif

source ~/scripts/set_ssh.csh
source ~/scripts/set_env.csh
source ~/scripts/set_prompt.csh
##source ~/scripts/set_ld_lib.csh

setenv CDS_AUTO_64BIT ALL
##setenv sys lnx86


##setenv QTDIR /lan/csv/products/PVE/12.11/DEV/pve_1211_hf2/install/cdsQTDev64b_472_33.12-p001lnx86/tools.lnx86/Qt/64bit

##setenv QTDIR /tmp/Qt/64bit

setenv QTDIR ${P4QTDIR}



# 
# Launching: ${P4DIR}/pvs/output/cdn_hier/lnx86/tools.lnx86/pvs/bin/64bit/ipvs 
# 


xhost + >& /dev/null
limit coredump unlimited




setenv MY_P4SITE pve_p4_mw
source /lan/csv/cm/scripts/p4/etc/p4.cshrc


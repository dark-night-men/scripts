
if ( ${?prompt} ) then
   if( "$prompt" == "" ) then
      unset prompt
   endif
endif


if ( $?have_term && $?TERM ) then
    if ("${TERM}" == "xterm" || "${TERM}" == "linux") then
        source ~/bin/.colors
    else
        set colors="no"
    endif
endif


if ( ${?prompt} ) then
source ~/bin/.prompt
endif


if($?prompt) then
    setenv LC_COLLATE C
    if( -f ~/.aliases ) then
        source ~/.aliases
    endif
    if($?tcsh) then
        if( -f ~/.complete.tcsh ) then
            source ~/.complete.tcsh
        endif

        #bindkey -v
        unset autologout
    else # we're in csh, not tcsh
        set filec
    endif

    set history  = 1000
    set savehist = 1000
    if ("${sys}" == "lnx86") then
        setenv LESS "--quit-if-one-screen --line-numbers --hilite-search --QUIET --no-init --buffers=50"
    endif
    setenv PAGER less
    setenv SILENT SILENT
    set cdpath = ( $home )
endif


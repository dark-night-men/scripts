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

# Deal with making or using an ssh-agent
if ( -f ~/.ssh/id_dsa ) then
   if ( -f ~/.ssh-agent ) then
      source ~/.ssh-agent >& /dev/null
   else
      touch ~/.ssh-agent
      chmod 0600 ~/.ssh-agent
   endif

   unset agentfound
   foreach x ( `pidof ssh-agent` )
      if ( "$x" == "$SSH_AGENT_PID" ) then
         set agentfound
      endif
   end

   if ( ! $?agentfound ) then
      ssh-agent |& grep -v 'Agent pid' > ~/.ssh-agent
      source ~/.ssh-agent >& /dev/null
   endif

   if( $?prompt ) then
      if( `ssh-add -l` == "The agent has no identities." ) then
         ssh-add
      endif
   endif
endif
# Done with ssh-agents
###############################################################################


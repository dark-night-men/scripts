# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
#set -x

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=5000
export HISTFILESIZE=20000
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export PROMPT_COMMAND="history -a;  history -r; $PROMPT_COMMAND"
export HISTTIMEFORMAT='%F %T '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


#export LD_LIBRARY_PATH=/usr/NX/lib:${LD_LIBRARY_PATH}
#export PATH=/usr/NX/bin:${PATH}
# export PATH=/root/.local/bin:~/scripts:/usr/lib/x86_64-linux-gnu/qt5/bin:/usr/local/Qt/Qt_5.5.0_1/bin:${PATH}
# export LD_LIBRARY_PATH=/usr/local/Qt/Qt_5.5.0_1/lib:/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}

export Qt6_DIR=/usr/lib/qt-6.8.1
export LLVM_C=/usr/local/llvm_custom_01
export PATH=/root/.local/bin:$LLVM_C/bin:~/scripts:${Qt6_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=$LLVM_C/lib/:${Qt6_DIR}/lib:/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}

export DISPLAY=:0

#stty -ixon  #Disable freeze term with Ctrl-s unfreeze Ctrl-q

if [[ -d /usr/local/share/vim/vim82 ]] ; then
    export VIMRUNTIME=/usr/local/share/vim/vim82
# else
#     echo /usr/local/share/vim/vim82 does not exist
fi

if [[ -d /usr/local/share/vim/vim90 ]] ; then
    export VIMRUNTIME=/usr/local/share/vim/vim90
# else
#     echo /usr/local/share/vim/vim90 does not exist
fi

if [[ -d /usr/local/share/vim/vim91 ]] ; then
    export VIMRUNTIME=/usr/local/share/vim/vim91
# else
#     echo /usr/local/share/vim/vim90 does not exist
fi

export VISUAL=vim  #Ctrl-x Ctrl-e edit cmd line in vim

set -o vi
#eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

#export TERM=xterm
set +x

# eval $(ssh-agent -s)


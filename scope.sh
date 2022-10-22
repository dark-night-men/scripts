#!/bin/bash

#set echo

##ctags -R -f .tags --extra=+q --languages=C++,C,Tcl,Perl,Lua --c++-kinds=+p --fields=+iaS

gtags
gtags --objdir
ctags -R --extras=+q --languages=C++,C,Tcl,Perl,Lua,Kotlin,Go,Python,Vala --c++-kinds=+p --fields=+iaS 

find `pwd -P` '(' -name "*.vala" -o -name 'main.cpp' -o -name "*.kt" -o -name "*.kts" -o -name "*.go" -o -name "*.lua" -o -name "*.[ch]" -or -name "*.[ch]pp" -or -name "*.[ch]xx" -or -name "*.cc" -or -name "*.hh" -or -name "*.il" -or -name "*.pl" -or -name "*.py" -or -name "[mM]akefile" ')' -and -not '(' -path "*/build/*" -o -path "*/.moc/*" ')'  > cscope.files


cscope -b -q -k
rm cscope.files

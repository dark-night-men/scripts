#!/bin/bash

#set echo

##ctags -R -f .tags --extra=+q --languages=C++,C,Tcl,Perl,Lua --c++-kinds=+p --fields=+iaS

gtags
gtags --objdir
ctags -R --extra=+q --languages=C++,C --c++-kinds=+p --fields=+iaS 

find `pwd -P` '('  -name 'main.cpp' -o  -name "*.[ch]" -or -name "*.[ch]pp" -or -name "*.[ch]xx" -or -name "*.cc" -or -name "*.hh"  -or -name "[mM]akefile" ')' -and -not '(' -path "*/build/*" -o -path "*/.moc/*" ')'  > cscope.files

find `pwd -P` -ipath '*/libstdc++-v3/include/*'  >> cscope.files


cscope -b -q -k
rm cscope.files

#!/bin/sh

set echo

/grid/common/pkgs/ctags/latest/bin/ctags -R -f .tags --extra=+q --languages=C++,C,Tcl,Perl --c++-kinds=+p --fields=+iaS


/grid/common/pkgs/ctags/latest/bin/ctags -R --extra=+q --languages=C++,C,Tcl,Perl --c++-kinds=+p --fields=+iaS 

/grid/common/bin/find `pwd` '(' -name "*.[ch]" -or -name "*.[ch]pp" -or -name "*.[ch]xx" -or -name "*.cc" -or -name "*.hh" -or -name "*.il" -or -name "*.pl" -or -name "*.py" -or -name "[mM]akefile" ')' -and -not -path "./output/*" > cscope.files

cscope -b -q -k
rm cscope.files

#!/bin/bash
#https://docs.ctags.io/en/latest/man/ctags.1.html

#set echo

##ctags -R -f .tags --extra=+q --languages=C++,C,Tcl,Perl,Lua --c++-kinds=+p --fields=+iaS

gtags
gtags --objdir
# ctags -R --extras=+q --languages=all --language-force=auto --c++-kinds=+p --fields=+iaS 
# ctags -R --extras=+q --languages=all --language-force=auto --c++-kinds=+pLl --fields=+iaS 
ctags -R --extras=+q --languages=all --language-force=auto --c++-kinds=+ADLNUZcdefghlmnpstuvxz --fields=+iaS 

find `pwd -P` '(' -name "*.sh" -o -name "*.json" -o -name "*.css" -o -name "*.html" -o -name "*.ts" -o -name "*.js" -o -name "*.java" -o -name "*.vala" -o -name 'main.cpp' -o -name "*.kt" -o -name "*.kts" -o -name "*.go" -o -name "*.lua" -o -name "*.[ch]" -or -name "*.[ch]pp" -or -name "*.[ch]xx" -or -name "*.cc" -or -name "*.hh" -or -name "*.il" -or -name "*.pl" -or -name "*.py" -or -name "[mM]akefile" ')' -and -not '(' -path "*/build/*" -o -path "*/.moc/*" ')'  > cscope.files

cscope -b -q -k
rm cscope.files

#!/bin/bash
#https://docs.ctags.io/en/latest/man/ctags.1.html

gtags
gtags --objdir

PWDP=$(pwd -P)

# ctags and cscope needs input files with different formats in case if spaces are in file/path names
find "$PWDP" -type f '(' -name "*.sh" -o -name "*.json" -o -name "*.css" -o -name "*.html" -o -name "*.ts" -o -name "*.js" -o -name "*.java" -o -name "*.vala" -o -name 'main.cpp' -o -name "*.kt" -o -name "*.kts" -o -name "*.go" -o -name "*.lua" -o -name "*.[ch]" -or -name "*.[ch]pp" -or -name "*.[ch]xx" -or -name "*.cc" -or -name "*.hh" -or -name "*.il" -or -name "*.pl" -or -name "*.py" -or -name "[mM]akefile" ')' -and -not '(' -path "*/build/*" -o -path "*/.moc/*" ')' -fprintf ctags.files '%p\n'
find "$PWDP" -type f '(' -name "*.sh" -o -name "*.json" -o -name "*.css" -o -name "*.html" -o -name "*.ts" -o -name "*.js" -o -name "*.java" -o -name "*.vala" -o -name 'main.cpp' -o -name "*.kt" -o -name "*.kts" -o -name "*.go" -o -name "*.lua" -o -name "*.[ch]" -or -name "*.[ch]pp" -or -name "*.[ch]xx" -or -name "*.cc" -or -name "*.hh" -or -name "*.il" -or -name "*.pl" -or -name "*.py" -or -name "[mM]akefile" ')' -and -not '(' -path "*/build/*" -o -path "*/.moc/*" ')' -fprintf cscope.files '"%p"\n'

ctags -L ctags.files --extras=+qFr --languages=all --language-force=auto --c++-kinds=+ADLNUZcdefghlmnpstuvxz --fields=+CEFKNPRSTZaefiklmnoprstxz

cscope -b -q -k

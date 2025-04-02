#!/bin/bash
#https://docs.ctags.io/en/latest/man/ctags.1.html

gtags
gtags --objdir

# Example for SCOPE_STARTING_POINTS_FILE
# /usr/lib/qt-6.8.1/include
# /usr/lib/qt-6.8.1/mkspecs/linux-g++
# /usr/include/opencv4

SCOPE_STARTING_POINTS_FILE=scope_starting_points.txt
SCOPE_STARTING_POINTS_FILE_ZERO=scope_starting_points.tmp.txt

printf '%s\n' $(pwd -P) >> ${SCOPE_STARTING_POINTS_FILE}

sed -i '/^[[:space:]]*$/d' ${SCOPE_STARTING_POINTS_FILE}

sort -u -o ${SCOPE_STARTING_POINTS_FILE}{,}
tr '\n' '\0' < $SCOPE_STARTING_POINTS_FILE > $SCOPE_STARTING_POINTS_FILE_ZERO


# ctags and cscope needs input files with different formats in case if spaces are in file/path names
find -files0-from ./"$SCOPE_STARTING_POINTS_FILE_ZERO" \
         -type f '(' -name "*.c++" -o -name "*.h++" -o -name "*.sh" -o -name "*.json" -o -name "*.css" -o -name "*.html" -o -name "*.ts" -o -name "*.js" -o -name "*.java" -o -name "*.vala" -o -name 'main.cpp' -o -name "*.kt" -o -name "*.kts" -o -name "*.go" -o -name "*.lua" -o -name "*.[ch]" -or -name "*.[ch]pp" -or -name "*.[ch]xx" -or -name "*.cc" -or -name "*.hh" -or -name "*.il" -or -name "*.pl" -or -name "*.py" -or -name "[mM]akefile" ')' -and -not '(' -path "*/build/*" -o -path "*/.moc/*" ')' -fprintf ctags.files.tmp '%p\n'

find -files0-from ./"$SCOPE_STARTING_POINTS_FILE_ZERO" \
-type f '(' -name "*.c++" -o -name "*.h++" -o -name "*.sh" -o -name "*.json" -o -name "*.css" -o -name "*.html" -o -name "*.ts" -o -name "*.js" -o -name "*.java" -o -name "*.vala" -o -name 'main.cpp' -o -name "*.kt" -o -name "*.kts" -o -name "*.go" -o -name "*.lua" -o -name "*.[ch]" -or -name "*.[ch]pp" -or -name "*.[ch]xx" -or -name "*.cc" -or -name "*.hh" -or -name "*.il" -or -name "*.pl" -or -name "*.py" -or -name "[mM]akefile" ')' -and -not '(' -path "*/build/*" -o -path "*/.moc/*" ')' -fprintf cscope.files.tmp '"%p"\n'

if ! cmp ctags.files ctags.files.tmp ; then
    mv ctags.files.tmp ctags.files
    ctags -R -L ctags.files --extras=+qFr --languages=all --language-force=auto \
        --c++-kinds=+ADLNUZcdefghlmnpstuvxz --fields=+CEFKNPRSTZaefiklmnoprstxz
fi

if ! cmp cscope.files cscope.files.tmp ; then
    mv cscope.files.tmp cscope.files
    cscope -b -q -k
fi

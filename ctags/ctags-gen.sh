#!/bin/bash

mkdir -p ~/.vim;

ctags --languages=C,C++ --langmap=C++:+. -h +. --file-scope=yes --C-kinds=+px --C++-kinds=+px --fields=+aiKmSz-fk --format=2 --tag-relative=yes -I __THROW -R -f ~/.vim/systags  /usr/include/

# ctags -f ~/.vim/localtags

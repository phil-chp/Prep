#!/bin/sh
##
## EPITECH PROJECT, 2021
## Prep
## File description:
## File cleaner, coding style checker, error handler script
## for epitech students.
## Feel free to edit this file to your liking.
## All credits go to the creators of the following programs
## Made by Philippe Cheype - Epitech Nsice - PGE2025
##
## Utilites needed:
##     NormEZ   - https://github.com/ronanboiteau/NormEZ/
##     bubulle  - https://github.com/aureliancnx/Bubulle-Norminette/
##     cppcheck - http://cppcheck.sourceforge.net/
##     deheader - https://gitlab.com/esr/deheader/
##
## Add this file with an alias to your terminal config for ease of use:
##     alias €prep="[path to this file]"
##
## Last updated: 03/06/21
##.


clear
if [ "$1" = "-f" ];
then
    make fclean -s./
else
    make fclean -s || { echo "\nEither you are not in a repo, or you are missing a Makefile\nStopping execution"; exit 1; }
fi
echo "Make fclean + Removing unnecessary files:"
echo "- Make fclean done"
find -name "*.o"      -delete && echo "- Removed .o files"
find -name "*.gc*"    -delete && echo "- Removed criterion temp files"
find -name "*.*~"     -delete && echo "- Removed emacs temp files"
find -name "*~"       -delete && echo "- Removed emacs buffer files"
find -name "#*#"      -delete && echo "- Removed emacs backup files"
find -name ".#*"      -delete && echo "- Removed even more emacs backup files"
find -name "*.vgcore" -delete && echo "- Removed valgrind log files"
find -name "*.out"    -delete && echo "- Removed random bin files"
find -name "*.tmp"    -delete && echo "- Removed temporary files made by vscode"
echo "\nRemoved temp files.\nPress enter to continue..."
read a



clear
ruby -v >/dev/null 2>&1
if [ $? -eq 0 ]
then
    ruby $NORMEZ -h >/dev/null 2>&1
    if [ $? -eq 0 ]
    then
        ruby $NORMEZ
        echo "\nNormEZ done."
    else
        echo "NormEZ is either not installed, corrupted or the path to the file is wrong."
        echo "If you have not set the correct path check step 3 of installation on the github page:"
        echo "> https://github.com/Philippe-cheype/Prep#3-setting-the-correct-paths"
        echo "Or download the files if you have not done it yet:"
        echo "> https://github.com/ronanboiteau/NormEZ/"
    fi
else
    echo "Ruby is either not installed or corrupted."
    echo "> https://www.ruby-lang.org/en/documentation/installation/"
fi

echo "\nPress enter to continue..."
read a



clear
bubulle -v >/dev/null 2>&1
if [ $? -eq 0 ]
then
    bubulle -ic -i g5,l2,o4,f002,l3
    echo "\nBubulle done."
else
    echo "Bubulle is either not installed or corrupted."
    echo "> https://github.com/aureliancnx/Bubulle-Norminette/"
fi
echo "\nPress enter to continue..."
read a



clear
cppcheck -h >/dev/null 2>&1
if [ $? -eq 0 ]
then
    cppcheck -q .
    echo "\nCppcheck done."
else
    echo "CppCheck is either not installed or corrupted."
    echo "> http://cppcheck.sourceforge.net/"
fi
echo "\nPress enter to continue..."
read a



clear
$DEHEADER -V >/dev/null 2>&1
if [ $? -eq 0 ]
then
    $DEHEADER -m "make all"
    echo "\nDeheader done."
else
    echo "Deheader is either not installed, corrupted or the path to the file is wrong."
    echo "If you have not set the correct path check step 3 of installation on the github page:"
    echo "> https://github.com/Philippe-cheype/Prep#3-setting-the-correct-paths"
    echo "Or download the files if you have not done it yet:"
    echo "> https://gitlab.com/esr/deheader/"
fi
echo "\nPrep finished.\nPress enter to exit..."
read a
clear

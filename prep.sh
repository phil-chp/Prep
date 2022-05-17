#!/usr/bin/env bash

# Prep
#
# File cleaner, coding style checker, error handler script
# for Epitech students.
# Feel free to edit this file to your liking.
# All credits go to the creators of the following programs
# Made by Philippe Cheype - Epitech Nice - PGE2025
#
# Utilites needed:
#     NormEZ   - https://github.com/ronanboiteau/NormEZ/
#     bubulle  - https://github.com/aureliancnx/Bubulle-Norminette/
#     cppcheck - http://cppcheck.sourceforge.net/
#     deheader - https://gitlab.com/esr/deheader/
#
# Github page: https://github.com/Philippe-cheype/Prep
#

if [ "$1" == "-h" ] || [ "$1" == "--help" ]
then
  echo -e "prep [-h] [-f]
A collection of useful tools for working with Epitech-like projects.

USAGE:
\t-h --help\tDisplay this help message
\t-f --force\tForce prep execution even if the working directory doesn't contain any Makefile."
  exit
fi

if [ "$1" == "-f" ] || [ "$1" == "--force" ]
then
  make fclean -s
else
  make fclean -s || { echo -e "Either you are not in a repo, or you are missing a Makefile\nStopping execution"; exit 1; }
fi

clear
echo "Make fclean + Removing unnecessary files:"
echo "- Make fclean done"
find . -name "*.o"         -delete && echo "- Removed .o files"
find . -name "*.gc*"       -delete && echo "- Removed criterion temp files"
find . -name "*.*~"        -delete && echo "- Removed emacs temp files"
find . -name "*~"          -delete && echo "- Removed emacs buffer files"
find . -name "#*#"         -delete && echo "- Removed emacs backup files"
find . -name ".#*"         -delete && echo "- Removed even more emacs backup files"
find . -name "*.vgcore"    -delete && echo "- Removed valgrind log files"
find . -name "*.out"       -delete && echo "- Removed random bin files"
find . -name "*.tmp"       -delete && echo "- Removed temporary files made by vscode"
find . -name "__pycache__" -delete && echo "- Removed python cache"
find . -name "*.hi"        -delete && echo "- Removed haskell interface files"
echo -e "\nRemoved temp files.\nPress enter to continue..."
read -r a


clear
if type normez
then
  normez
  echo -e "\nNormEZ done."
else
  echo "NormEZ wasn't found. Please re-install Prep or install NormEZ manually."
  echo "- Prep: https://github.com/Philippe-cheype/Prep"
  echo "- NormEZ: https://github.com/ronanboiteau/NormEZ/"
fi
echo -e "\nPress enter to continue..."
read -r a


clear
if type bubulle
then
  bubulle
  echo -e "\nBubulle done."
else
  echo "Bubulle wasn't found. Please re-install Prep or install Bubulle manually."
  echo "- Prep: https://github.com/Philippe-cheype/Prep"
  echo "- Bubulle: https://github.com/aureliancnx/Bubulle-Norminette/"
fi
echo -e "\nPress enter to continue..."
read -r a


clear
if type cppcheck
then
  cppcheck -q .
  echo -e "\nCppcheck done."
else
  echo "cppcheck wasn't found. Please re-install Prep or install cppcheck manually."
  echo "- Prep: https://github.com/Philippe-cheype/Prep"
  echo "- cppcheck: http://cppcheck.sourceforge.net/"
fi
echo -e "\nPress enter to continue..."
read -r a


clear
if type deheader
then
  deheader
  echo -e "\nDeheader done."
else
  echo "deheader wasn't found. Please re-install Prep or install deheader manually."
  echo "- Prep: https://github.com/Philippe-cheype/Prep"
  echo "- deheader: https://gitlab.com/esr/deheader/"
fi
echo -e "\nPrep finished.\nPress enter to exit..."
read -r a
clear

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

PREP_VERSION=1
PREP_NEW_VERSION=$(curl -fsSL https://raw.githubusercontent.com/Kyrela/Prep/master/prep.sh | grep -P "^PREP_VERSION=" | sed 's/PREP_VERSION=//g')
PREP_SHOULD_CLEAR=1

if [ "$PREP_VERSION" != "$PREP_NEW_VERSION" ]
then
  echo -e "New update has been found!\nCurrent version: $PREP_VERSION\nNew version: $PREP_NEW_VERSION"
  echo "Do you want to update? [y/n]"
  read -r res
  if [ "$res" == "y" ] || [ "$res" == "Y" ] || [ "$res" == "yes" ] || [ "$res" == "Yes" ] || [ "$res" == "YES" ]
  then
    sudo git clone https://github.com/Kyrela/Prep.git /tmp/prep
    sudo /tmp/prep/install.sh
    sudo rm -rf /tmp/prep
    prep
    exit $?
  fi
fi

if [[ "$*" == *"-v"* ]] || [[ "$*" == *"--version"* ]]
then
  echo "Prep version $PREP_VERSION"
  if [ "$PREP_VERSION" == "$PREP_NEW_VERSION" ]
  then
    echo "Up-to-date"
  else
    echo "Update available: $PREP_NEW_VERSION"
  fi
  exit
fi

if [[ "$*" == *"-h"* ]] || [[ "$*" == *"--help"* ]]
then
  echo -e "prep [-h] [-f] [-v]
A collection of useful tools for working with Epitech-like projects.

USAGE:
\t-h --help\tDisplay this help message
\t-f --force\tForce prep execution even if the working directory doesn't contain any Makefile
\t-v --version\tDisplay the actual Prep version
\t-c --no-clear\tDisable the terminal clearing behavior"
  exit
fi

if [[ "$*" == *"-c"* ]] || [[ "$*" == *"--no-clear"* ]]
then
  PREP_SHOULD_CLEAR=0
fi

if (! make fclean &> /dev/null) && [[ "$*" != *"-f"* ]] && [[ "$*" != *"--force"* ]]
then
  echo -e "No Makefile detected, stopping execution.\n\e[3mTo force prep to continue execution, use -f\e[23m"
  exit 1
fi

if [ "$PREP_SHOULD_CLEAR" == "1" ]; then clear; fi
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


if [ "$PREP_SHOULD_CLEAR" == "1" ]; then clear; fi
if type normez &> /dev/null
then
  normez
  echo -e "\nNormEZ done."
else
  echo "NormEZ wasn't found. Please re-install Prep or install NormEZ manually."
  echo "- Prep: https://github.com/Philippe-cheype/Prep"
  echo "- NormEZ: https://github.com/ronanboiteau/NormEZ/"
fi
echo "Press enter to continue..."
read -r a


if [ "$PREP_SHOULD_CLEAR" == "1" ]; then clear; fi
if type bubulle &> /dev/null
then
  bubulle
  echo -e "\nBubulle done."
else
  echo "Bubulle wasn't found. Please re-install Prep or install Bubulle manually."
  echo "- Prep: https://github.com/Philippe-cheype/Prep"
  echo "- Bubulle: https://github.com/aureliancnx/Bubulle-Norminette/"
fi
echo "Press enter to continue..."
read -r a


if [ "$PREP_SHOULD_CLEAR" == "1" ]; then clear; fi
if type cppcheck &> /dev/null
then
  cppcheck -q .
  echo -e "\nCppcheck done."
else
  echo "cppcheck wasn't found. Please re-install Prep or install cppcheck manually."
  echo "- Prep: https://github.com/Philippe-cheype/Prep"
  echo "- cppcheck: http://cppcheck.sourceforge.net/"
fi
echo "Press enter to continue..."
read -r a


if [ "$PREP_SHOULD_CLEAR" == "1" ]; then clear; fi
if type deheader &> /dev/null
then
  deheader
  echo -e "\nDeheader done."
else
  echo "deheader wasn't found. Please re-install Prep or install deheader manually."
  echo "- Prep: https://github.com/Philippe-cheype/Prep"
  echo "- deheader: https://gitlab.com/esr/deheader/"
fi
echo -e "Prep finished.\nPress enter to exit..."
read -r a
if [ "$PREP_SHOULD_CLEAR" == "1" ]; then clear; fi

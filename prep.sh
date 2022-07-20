#!/usr/bin/env bash

# Prep
#
# File cleaner, coding style checker, error handler script
# for Epitech students.
# Feel free to edit this file to your liking.
# All credits go to the creators of the following programs
# Made by Philippe Cheype - Epitech Nice - PGE2025
#
# Utilities needed:
#     NormEZ   - https://github.com/ronanboiteau/NormEZ/
#     bubulle  - https://github.com/aureliancnx/Bubulle-Norminette/
#     cppcheck - http://cppcheck.sourceforge.net/
#     deheader - https://gitlab.com/esr/deheader/
#
# Github page: https://github.com/Philippe-cheype/Prep
#

PREP_VERSION=1.2.1
PREP_NEW_VERSION="$PREP_VERSION"



# ========================================== Argument parsing ====================================== #
LONGOPTS=help,version,force,no-screen,no-update
OPTIONS=hvfSU
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name prep -- "$@")
if [ "$?" != 0 ]
then
    exit 2
fi
eval set -- "$PARSED"

h=0 v=0 f=0 S=0 U=0

while [ "$#" != 0 ]
do
    case $1 in
        -h|--help) h=1;;
        -v|--version) v=1;;
        -f|--force) f=1;;
        -S|--no-screen) S=1;;
        -U|--no-update) U=1;;
        --);;
        *) echo "prep: invalid argument '$1'"; exit 1;;
    esac
    shift
done



# ============================================== Misc ============================================== #
if [ $U == 0 ]
then
  PREP_NEW_VERSION=$(curl -fsSL https://raw.githubusercontent.com/Philippe-cheype/Prep/master/prep.sh | grep -P "^PREP_VERSION=" | sed 's/PREP_VERSION=//g')
fi

if [ "$PREP_VERSION" != "$PREP_NEW_VERSION" ]
then
  echo -e "New update has been found!\nCurrent version: $PREP_VERSION\nNew version: $PREP_NEW_VERSION"
  echo -n "Do you want to update? [y/n] "
  read -r res
  if [ "$res" == "y" ] || [ "$res" == "Y" ] || [ "$res" == "yes" ] || [ "$res" == "Yes" ] || [ "$res" == "YES" ]
  then
    sudo git clone https://github.com/Philippe-cheype/Prep.git /tmp/prep -q
    sudo /tmp/prep/install.sh > /dev/null
    cp -rf /tmp/prep/* .
    sudo rm -rf /tmp/prep
    echo -e "Prep updated successfully\n"
    prep "$@"
    exit $?
  fi
fi

if [ $v == 1 ]
then
  echo "Prep version: $PREP_VERSION"
  if [ "$PREP_VERSION" == "$PREP_NEW_VERSION" ]
  then
    echo "Up-to-date"
  else
    echo "Update available: $PREP_NEW_VERSION"
  fi
  exit
fi

if [ $h == 1 ]
then
  echo -e "prep [-hvfSU]
A collection of useful tools for working with Epitech-like projects.

USAGE:
\t-h --help\tDisplay this help message
\t-v --version\tDisplay the actual Prep version
\t-f --force\tForce prep execution even if the working directory doesn't contain any Makefile
\t-S --no-screen\tDisable the terminal screening behavior
\t-U --no-update\tDisable the update check"
  exit
fi

if (! ls Makefile &> /dev/null) && [ $f == 0 ]
then
  echo -e "prep: no Makefile detected, stopping execution.\n\e[3mTo force prep to continue execution, use -f\e[23m"
  exit 1
fi


# ============================================ Mr. Clean =========================================== #
if [ $S == 0 ]; then tput smcup; clear; fi
echo "Make fclean + Removing unnecessary files:"
make -s fclean                     && echo "- Make fclean done"
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
read -r



# ============================================= NormEZ ============================================= #
if [ $S == 0 ]; then clear; fi
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
read -r



# ============================================= Bubulle ============================================ #
if [ $S == 0 ]; then clear; fi
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
read -r



# ============================================ CppCheck ============================================ #
if [ $S == 0 ]; then clear; fi
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
read -r



# =========================================== Deheader ============================================= #
if [ $S == 0 ]; then clear; fi
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
read -r



if [ $S == 0 ]; then tput rmcup; fi

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

# ============================================= System ============================================= #

PREP_VERSION=1.3.0
PREP_NEW_VERSION="$PREP_VERSION"

trap ctrl_c INT

ctrl_c() {
  if [ "$S" == 0 ]; then tput rmcup; fi
  echo "Stopping prep execution..."
  rm -rf /tmp/prep_temp
  exit 1
}

run_program() {
  if [ "$S" == 0 ]; then clear; fi
  prg="$1" prg_name="$2" prg_url="$3" completion_msg="$4"
  if ( ! type "$prg" &> /dev/null )
  then
    echo "$prg_name wasn't found. Please re-install Prep or install $prg_name manually."
    echo "- Prep: https://github.com/Philippe-cheype/Prep"
    echo "- $prg_name: $prg_url"
    return 1
  fi

  shift; shift; shift; shift
  "$prg" "$@"
  echo -e "$completion_msg"
  read -r
  return 0
}



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

while true
do
    case $1 in
        -h|--help) h=1;;
        -v|--version) v=1;;
        -f|--force) f=1;;
        -S|--no-screen) S=1;;
        -U|--no-update) U=1;;
        --) shift; break;;
        *) echo "prep : invalid argument -- '$1'"; exit 1;;
    esac
    shift
done

ignored_files=$*
for file in $ignored_files
do
  if ! ls "$file" &> /dev/null
  then
    echo "prep : Directory '$file' does not exist."
    exit 1
  fi
done



# ============================================= Update ============================================= #
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



# ======================================= Help & versioning ======================================== #
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
  echo "prep [-hvfSU] [<exclude-path>...]
A collection of useful tools for working with Epitech-like projects.

USAGE:
        -h --help       Display this help message
        -v --version    Display the actual Prep version
        -f --force      Force prep execution even if the working directory doesn't contain any Makefile
        -S --no-screen  Disable the terminal screening behavior
        -U --no-update  Disable the update check

        exclude-path    The files/directories to exclude from the prep analyse"
  exit
fi



# ============================================ Security ============================================ #
if (! ls Makefile &> /dev/null) && [ $f == 0 ]
then
  echo -e "prep : no Makefile detected, stopping execution.\n\e[3mTo force prep to continue execution, use -f\e[23m"
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



# ======================================== File exclusion ========================================== #
if [ "$ignored_files" != "" ]
then
  rm -rf /tmp/prep_temp
  for file in $ignored_files
  do
    exclude_opts+=( "--exclude=$file" )
  done
  rsync -aq "${exclude_opts[@]}" ./ /tmp/prep_temp
  cd /tmp/prep_temp || (echo "prep : Could not change directory to /tmp/prep_temp"; exit 1)
fi



# ============================================ Programs ============================================ #
run_program normez "NormEZ" "https://github.com/ronanboiteau/NormEZ/" "Press enter to continue..."
run_program bubulle "Bubulle" "https://github.com/aureliancnx/Bubulle-Norminette/" "Press enter to continue..."
run_program cppcheck "CppCheck" "http://cppcheck.sourceforge.net/" "Press enter to continue..." -q .
run_program deheader "Deheader" "https://gitlab.com/esr/deheader/" "Prep finished.\nPress enter to exit...."



# ============================================ Cleanup ============================================= #
rm -rf /tmp/prep_temp
if [ $S == 0 ]; then tput rmcup; fi
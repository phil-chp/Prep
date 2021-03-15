#!/bin/bash
##
## EPITECH PROJECT, 2021
## FILE PREP INSTALLER
## File description:
## Repo cleaning, coding style check
## error handling script and unused/missing header file checker
##
## For Epitech students
## by Philippe Cheype
##

clear
echo "------------------------- Prep Installer -------------------------\n\n"
echo "Utilites needed:"
echo "    NormEZ   - https://github.com/ronanboiteau/NormEZ"
echo "    bubulle  - https://github.com/aureliancnx/Bubulle-Norminette"
echo "    cppcheck - http://cppcheck.sourceforge.net"
echo "    deheader - https://gitlab.com/esr/deheader"
echo "\n\nUse '€prep' in your root folder to run the script."
echo "Restart your terminal."
echo "------------------------------------------------------------------\n\n"

echo << EOF
##
## EPITECH PROJECT, 2021
## Prep
## File description:
## File cleaner, coding style checker, error handler script
## for tech1 epitech students.
## Feel free to edit this file to your liking.
## All credits go to the creators of the following programs
## Made by Philippe Cheype - Epitech Nice
##
## Utilites needed:
##     NormEZ   - https://github.com/ronanboiteau/NormEZ
##     bubulle  - https://github.com/aureliancnx/Bubulle-Norminette
##     cppcheck - http://cppcheck.sourceforge.net
##     deheader - https://gitlab.com/esr/deheader
##
## Add this file with an alias to your terminal config for ease of use:
##     alias [name]="[path to this file]"
##

clear
echo "Make fclean + Removing temp files:"
make fclean -s                && echo "- Make fclean done"
find -name "*.o"      -delete && echo "- Removed .o files"
find -name "*.gc*"    -delete && echo "- Removed criterion temp files"
find -name "*.*~"     -delete && echo "- Removed emacs temp files"
find -name "*~"       -delete && echo "- Removed emacs buffer files"
find -name "#*#"      -delete && echo "- Removed emacs backup files"
find -name "*.vgcore" -delete && echo "- Removed valgrind log files"
find -name "*.out"    -delete && echo "- Removed random bin files"

echo "\nRemoved temp files.\nPress enter to continue..."
read a
clear
# ADD NORMEZ PATH/ALIAS (ex: ruby $HOME/Documents/NormEZ/NormEZ.rb)

echo "\nNormEZ done.\nPress enter to continue..."
read a
clear
# ADD BUBULLE PATH/ALIAS (ex: bubulle -ic -i g5,l2,o4,f002,l3)

echo "\nBubulle done.\nPress enter to continue..."
read a
clear
# ADD CPPCHECK PATH/ALIAS (ex: cppcheck -q .)

echo "\nCppcheck done.\nPress enter to continue..."
read a
clear
# ADD DEHEADER PATH/ALIAS (ex: $HOME/Documents/3Programs/deheader/deheader)

echo "\nDeheader done.\nProcess finished.\nPress enter to end..."
read a
clear
EOF > $HOME/Documents/prep.sh

chmod +x $HOME/Documents/prep.sh
echo "alias €prep='$HOME/Documents/prep.sh'" >> $HOME/.bashrc && source $HOME/.bashrc
echo "alias €prep='$HOME/Documents/prep.sh'" >> $HOME/.zshrc  && source $HOME/.zshrc

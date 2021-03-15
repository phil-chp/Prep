# Prep

I made this program to make my life easier
Espacially when working on TTY, all it does is execute
usefull programs to check if you did your work correctly

Utilites needed:
- NormEZ:   https://github.com/ronanboiteau/NormEZ
- bubulle:  https://github.com/aureliancnx/Bubulle-Norminette
- cppcheck: http://cppcheck.sourceforge.net/
- deheader: https://gitlab.com/esr/deheader

Add this file with an alias to your terminal config for ease of use:
    alias [name]="[path to the prep.sh file]"


## What it do

Make fclean to remove all your useless files
Removes even more useless files to be sure you won't have a 'moulie' error

NormEZ checks for coding style errors
bubulle checks for even more coding style errors. (Don't trust everything bubulle says, it's way to aggressive when checking for errors, if you don't understand the error than you are probably right.)
(both these programs were created by epitech students)

Cppcheck, runs through your program and does a veryyy in depth check for coding errors. (Sometimes, it too is too agressive so don't fully trust it)

And at last deheader checks for unused header files and mentions them so you can remove them, it also checks for missing header files.

I prefer to use these programs that check too much instead of just what's important, it's always better to be in control so that no errors slip by.


## Disclaimer

I hold no rights on these programs all credit goes their creators. All that I'm doing is putting them together in a simple script.

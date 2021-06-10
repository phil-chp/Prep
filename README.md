# Prep

I made this program to make my life easier
Espacially when working on TTY, all it does is execute
usefull programs to check if you did your work correctly

## Installation

### 1. Download utilities
- Ruby:     https://www.ruby-lang.org/en/documentation/installation/
- NormEZ:   https://github.com/ronanboiteau/NormEZ
- bubulle:  https://github.com/aureliancnx/Bubulle-Norminette
- cppcheck: http://cppcheck.sourceforge.net/
- deheader: https://gitlab.com/esr/deheader

### 2. Install
- Download the prep.sh file
- Place it somewhere you would like
- Give the file the permissions necessary for execution:

```sh
chmod +x "/path/to/file/prep.sh"
```
- Set an alias in your terminal config file for ease of use:

```sh
alias €prep="/path/to/file/prep.sh"
```

### 3. Setting the correct paths
Open the prep.sh file and go to line 24 & 25, on the variables NORMEZ and DEHEADER set your paths accordingly.

If you don't have these programs, look at step 1 of the installation.

### 4. Execute
Either open a new terminal or reload your current one using:

```sh
source ~/.bashrc
```
(replace bashrc by your terminal config file)

Finally execute Prep by calling the alias you set, by default:

```sh
€prep
```

For safety reasons prep won't execute in a folder not containing a Makefile, you can still force it though:
```sh
€prep -f
```
<span style="color:red">Make sure you are not about to loose files before executing this!</span>

## What it do

Make fclean to remove all your unwanted files.

Removes even more undesired files to be sure you won't have a 'moulie' error.

NormEZ checks for coding style errors.
bubulle checks for even more coding style errors.
(both these programs were created by epitech students)

CppCheck, runs through your program and does a very in depth check for coding errors. (ex: Memory leaks)

Deheader checks for unused header files and/or missing ones, so you always have everything up to date.

## Disclaimer

I hold no rights on these programs all credit goes their creators. All that I'm doing is putting them together in a simple script.

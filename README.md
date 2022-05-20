# Prep

A collection of useful tools for working with Epitech-like projects.

## Functionalities

- Execute the `make` rule `fclean`
- Remove temporary files
- executes Normez, an Epitech coding-style checker
- executes Bubulle, another Epitech coding-style checker
- executes cppcheck, a static analysis tool to detect bugs and dangerous coding construct
- executes dheader, a header checker to check unused, forgotten inclusions and cohesion problems

## Installation

Clone the repo or download it, then run `install.sh`

```
install.sh [-h] [-r]
Install the Prep script on the system

USAGE:
        -h --help               Display this message
        -r --remove             Remove the program from the system
```

You can also just copy/paste this script:
```bash
git clone https://github.com/Philippe-cheype/Prep.git prep && cd prep && sudo ./install.sh && cd .. && rm -rf prep 
```

## Usage

```
prep [-h] [-f]
A collection of useful tools for working with Epitech-like projects.

USAGE:
        -h --help       Display this help message
        -f --force      Force prep execution even if the working directory doesn't contain any Makefile.
```

For safety reasons prep won't execute in a folder not containing a Makefile, you can still force it using
the `-f` flag


> <span style="color:red">Make sure you are not about to loose files before executing this!</span>

## Tools used

- [NormEZ](https://github.com/ronanboiteau/NormEZ/)
- [Bubulle](https://github.com/aureliancnx/Bubulle-Norminette/)
- [cppcheck](http://cppcheck.sourceforge.net/)
- [deheader](https://gitlab.com/esr/deheader/)

### Disclaimer

I hold no rights on these programs all credit goes their creators.
All that I'm doing is putting them together in a simple script.
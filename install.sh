#!/usr/bin/env bash

SEPARATOR="---------------------"



# ======================================== Argument parsing ======================================== #
h=0 R=0
while [[ $# -gt 0 ]]
do
  case "$1" in
    -h|--help) h=1;;
    -R|--remove) R=1;;
    *) echo "install.sh : invalid option -- '$1'"; exit 1;;
  esac
  shift
done



# ============================================== Misc ============================================== #
if [ $h == 1 ]
then
  echo -e "install.sh [-h] [-R]"
  echo -e "Install the Prep script on the system\n"
  echo -e "USAGE:"
  echo -e "\t-h --help\tDisplay this message"
  echo -e "\t-R --remove\tRemove the program from the system"
  exit
fi

if [ "$EUID" -ne 0 ]
  then echo "prep: you have to run this script as root!"
  exit 1
fi

if [ $R == 1 ]
then
  echo "Removing Prep..."
  rm -rf /usr/local/bin/prep
  echo "Prep removed!"
  echo "You might also want to remove the dependencies. Bubulle, Normez, cppcheck and deheader were used by prep."
  exit
fi

function install_program {
  if [ -z "$1" ]; then
    return
  fi

  if ( type dnf &> /dev/null ); then
    dnf install "$1" -y
  elif ( type yum &> /dev/null ); then
    yum install "$1" -y
  elif ( type apt-get &> /dev/null ); then
    apt-get install "$1" -y
  elif ( type brew &> /dev/null ); then
    brew install cppcheck
  elif ( type emerge &> /dev/null ); then
    emerge dev-lang/"$1"
  elif ( type pacman &> /dev/null ); then
    pacman -S "$1"
  elif ( type brew &> /dev/null ); then
    brew install "$1"
  elif ( type pkg &> /dev/null ); then
    pkg install "$1"
  elif ( type doas &> /dev/null ); then
    doas pkg_add "$1"
  elif ( type snap &> /dev/null ); then
    snap install "$1" --classic -y
  else
    echo -e "You don't have $1 installed, or it wasn't found, and we couldn't find any compatible package manager to install it!"
    echo -e "You can try to install it manually: https://www.google.com/search?q=$1\n"
    exit 1
  fi

  install_program "${@:2}"
}


echo -e "Installing Prep...\n\n"



# ============================================== getopt ============================================== #
getopt --test &> /dev/null
if [ "$?" != 4 ]
then
  echo "Enhanced getopt is not installed on your system. Please install it manually."
  echo -e "You can verify it by running: \n\tgetopt --test; echo \$?"
  echo "If it displays 4, it means it is correctly installed."
  echo -e "\nMore infos here:\nhttps://manpages.ubuntu.com/manpages/bionic/man1/getopt.1.html"
  exit 1
fi



# ============================================== Ruby ============================================== #
if ! type ruby &> /dev/null
then
  echo -e "Ruby installation...\n$SEPARATOR"
  install_program "ruby"
  if ! type ruby &> /dev/null
  then
    echo -e "$SEPARATOR\nRuby installation failed, or it wasn't found. Please install it manually on https://www.ruby-lang.org/en/documentation/installation/\n"
    exit 1
  fi
  echo -e "$SEPARATOR\nRuby installed!\n"
fi



# ============================================= NormEZ ============================================= #
if ! type normez &> /dev/null
then
  echo -e "Normez installation...\n$SEPARATOR"
  git clone https://github.com/ronanboiteau/NormEZ.git /tmp/normez
  make install -C /tmp/normez/
  rm -rf /tmp/normez/
  if ! type normez &> /dev/null
  then
    echo -e "$SEPARATOR\nNormEZ installation failed, or it wasn't found. Please install it manually on https://github.com/ronanboiteau/NormEZ/"
    exit 1
  fi
  echo -e "$SEPARATOR\nNormez installed!\n"
fi



# ============================================= Bubulle ============================================ #
if ( ! type bubulle &> /dev/null ); then
  echo -e "Bubulle installation...\n$SEPARATOR"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/aureliancnx/Bubulle-Norminette/master/install_bubulle.sh)"
  if ( ! type bubulle &> /dev/null ); then
    echo -e "$SEPARATOR\nBubulle installation failed, or it wasn't found. Please install it manually on https://github.com/aureliancnx/Bubulle-Norminette/\n"
    exit 1
  else

    echo -e "Installing Bubulle dependencies...\n\n"
    if ( ! type python3 &> /dev/null ); then
      echo -e "Installing python3 needed by Bubulle dependencies...\n$SEPARATOR"
      install_program "python3"
      if ( ! type python3 &> /dev/null ); then
        echo -e "$SEPARATOR\nBubulle dependencies installation failed, or it wasn't found. Check if you have a version of python3.X installed. (you can try to install it at: https://www.python.org/downloads/)"
        exit 1
      fi
    fi

    if ( ! python3 -m pip list | grep pycparser &> /dev/null ); then
      echo -e "Bubulle dependencies installation...\n$SEPARATOR"
      python3 -m pip install pycparser pyparsing pycparser-fake-libc --user
      if ( ! python3 -m pip list | grep pycparser &> /dev/null ); then
        echo -e "$SEPARATOR\nBubulle dependencies installation failed, or it wasn't found. Try to install 'pycparser' and 'pyparsing' with 'pip'."
        exit 1
      fi
    fi

  fi
  echo -e "$SEPARATOR\nBubulle installed!\n"
fi



# ============================================ CppCheck ============================================ #
if ( ! type cppcheck &> /dev/null ); then
  echo -e "cppcheck installation...\n$SEPARATOR"
  install_program "cppcheck"
  if ( ! type cppcheck &> /dev/null ); then
    echo -e "$SEPARATOR\ncppcheck installation failed, or it wasn't found. Please install it manually on https://cppcheck.sourceforge.io/\n"
    exit 1
  fi
  echo -e "$SEPARATOR\ncppcheck installed!\n"
fi



# ============================================ Deheader ============================================ #
if ( ! type deheader &> /dev/null ); then
  echo -e "deheader installation...\n$SEPARATOR"
  git clone https://gitlab.com/esr/deheader.git /tmp/deheader
  cp -f /tmp/deheader/deheader /usr/local/bin/deheader
  chmod 755 /usr/local/bin/deheader
  rm -rf /tmp/deheader/
  if ( ! type deheader &> /dev/null ); then
    echo -e "$SEPARATOR\ndeheader installation failed, or it wasn't found. Please install it manually on https://gitlab.com/esr/deheader/\n"
    exit 1
  fi
  echo -e "$SEPARATOR\ndeheader installed!\n"
fi



cp -f prep.sh /usr/local/bin/prep
chmod 755 /usr/local/bin/prep

if ( ! type prep &> /dev/null ); then
  echo -e "Prep installation failed!\nBe sure that '/usr/local/bin/' is in the PATH, and that this script as permissions to write into it."
  exit 1
fi

echo "Prep installed!"
echo "To use it, just call 'prep'"
echo "Usage: prep [-hvfSU] [<exclude-path>...]"
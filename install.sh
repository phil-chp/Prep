#!/usr/bin/env bash
if [ "$1" == "--help" ] || [ "$1" == "-h" ]
then
  echo -e "install.sh [-h] [-r]
Install the Prep script on the system

USAGE:
\t-h --help\t\tDisplay this message
\t-r --remove\t\tRemove the program from the system"
  exit
fi

if [ "$EUID" -ne 0 ]
  then echo "You have to run this script as root!"
  exit
fi

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]
then
  echo "Removing Prep..."
  rm -rf /usr/local/bin/prep
  echo "Prep removed!"
  echo "You might also want to remove the dependencies. Bubulle, Normez, cppcheck and deheader were used by prep."
  exit
fi

echo -e "Installing Prep...\n\n"

# Ruby installation
if ! type ruby &> /dev/null
then
  echo -e "Ruby installation...\n---------------------"
  if type dnf &> /dev/null
  then
    dnf install ruby -y
  elif type yum &> /dev/null
  then
    yum install ruby -y
  elif type apt-get &> /dev/null
  then
    apt-get install ruby -y
  elif type emerge &> /dev/null
  then
    emerge dev-lang/ruby
  elif type pacman &> /dev/null
  then
    pacman -S ruby
  elif type brew &> /dev/null
  then
    brew install ruby
  elif type pkg &> /dev/null
  then
    pkg install ruby
  elif type doas &> /dev/null
  then
    doas pkg_add ruby
  elif type snap &> /dev/null
  then
    snap install ruby --classic -y
  else
    echo -e "You don't have Ruby installed, or it wasn't found, and we couldn't find any compatible package manager to install it!"
    echo -e "You can install it manually on https://www.ruby-lang.org/en/documentation/installation/\n"
    exit 1
  fi
  if ! type ruby &> /dev/null
  then
    echo -e "---------------------\nRuby installation failed, or it wasn't found. Please install it manually on https://www.ruby-lang.org/en/documentation/installation/\n"
    exit 1
  fi
  echo -e "---------------------\nRuby installed!\n"
fi

# Normez installation
if ! type normez &> /dev/null
then
  echo -e "Normez installation...\n---------------------"
  git clone https://github.com/ronanboiteau/NormEZ.git /tmp/normez
  make install -C /tmp/normez/
  rm -rf /tmp/normez/
  if ! type normez &> /dev/null
  then
    echo -e "---------------------\nNormEZ installation failed, or it wasn't found. Please install it manually on https://github.com/ronanboiteau/NormEZ/"
    exit 1
  fi
  echo -e "---------------------\nNormez installed!\n"
fi

# Bubulle installation
if ! type bubulle &> /dev/null
then
  echo -e "Bubulle installation...\n---------------------"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/aureliancnx/Bubulle-Norminette/master/install_bubulle.sh)"
  if ! type bubulle &> /dev/null
  then
    echo -e "---------------------\nBubulle installation failed, or it wasn't found. Please install it manually on https://github.com/aureliancnx/Bubulle-Norminette/\n"
    exit 1
  fi
  echo -e "---------------------\nBubulle installed!\n"
fi

# CppCheck installation
if ! type cppcheck &> /dev/null
then
  echo -e "cppcheck installation...\n---------------------"
  if type dnf &> /dev/null
  then
    dnf install cppcheck -y
  elif type yum &> /dev/null
  then
    yum install cppcheck -y
  elif type apt-get &> /dev/null
  then
    apt-get install cppcheck -y
  elif type brew &> /dev/null
  then
    brew install cppcheck
  else
    echo -e "You don't have cppcheck installed, or it wasn't found, and we couldn't find any compatible package manager to install it!"
    echo -e "You can install it manually on https://cppcheck.sourceforge.io/\n"
    exit 1
  fi
  if ! type cppcheck &> /dev/null
  then
    echo -e "---------------------\ncppcheck installation failed, or it wasn't found. Please install it manually on https://cppcheck.sourceforge.io/\n"
    exit 1
  fi
  echo -e "---------------------\ncppcheck installed!\n"
fi

# Deheader installation
if ! type deheader &> /dev/null
then
  echo -e "deheader installation...\n--------------------"
  git clone https://gitlab.com/esr/deheader.git /tmp/deheader
  cp -f /tmp/deheader/deheader /usr/local/bin/deheader
  chmod 755 /usr/local/bin/deheader
  rm -rf /tmp/deheader/
  if ! type deheader &> /dev/null
  then
    echo -e "---------------------\ndeheader installation failed, or it wasn't found. Please install it manually on https://gitlab.com/esr/deheader/\n"
    exit 1
  fi
  echo -e "---------------------\ndeheader installed!\n"
fi

cp -f prep.sh /usr/local/bin/prep
chmod 755 /usr/local/bin/prep

if ! type prep &> /dev/null
then
  echo -e "Prep installation failed!\nBe sure that '/usr/local/bin/' is in the PATH, and that this script as permissions to write into it."
  exit 1
fi

echo "Prep installed!"
echo "To use it, just call the 'prep' command"
echo "usage: prep [-h] [-f]"
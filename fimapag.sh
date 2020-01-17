#!/bin/bash

# Author : Antoine Paix
# Github : github.com/AntoinePaix
#
# *******FInd MAn PAGes*******
#
# Description : Fimapag is a bash script that allows you to display
# all man pages present in a deb package (debian/ubuntu/mint distros)

PAQUET="${1}"

if [ "$#" -ne 1 ] ; then
  echo "You must indicate in argument the name of a package."
  echo "USE : bash $(basename "$0") <PACKAGE>"
  exit 1
fi

dpkg -L "${PAQUET}" > /dev/null 2>&1

if [ "$?" -ne 0 ] ; then
  echo -e "Package \033[38;5;14m$PAQUET\033[0m does not exist or is not installed on your system."
  echo -e "You can check the list of packages installed on your system with the command : \033[38;5;10mdpkg -l\033[0m"
  exit 2
fi

dpkg -L "${PAQUET}" | grep "man[1-9]/" > /dev/null 2>&1

if [ "$?" -ne 0 ] ; then
  echo -e "Package \033[38;5;14m$PAQUET\033[0m does not contain a manual page."
  exit 3
fi

basename -a $(dpkg -L "${PAQUET}" | grep "man[1-9]/") | sed 's/.[1-9].gz$//g' | uniq -u | xargs whatis

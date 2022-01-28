#!/bin/bash
echo "Welcome to the Arch EasyInstall script."
echo "Created by Logan Alldredge, owner and proprietor of One Enterprises."
echo "Warning: This could potentially destroy your computer. Press ctrl + c to cancel at any time."
read "Continue? Y or N" yn_1
case $yn_1 in
[Yy]* ) echo "Continuing.";;
[Nn]* ) done;;
* ) echo "Please answer yes or no.";;
esac
echo "This segment of this program is supposed to format and prepare disks for the installation of Arch Linux."

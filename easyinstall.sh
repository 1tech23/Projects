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
# to create the partitions programatically (rather than manually)
# we're going to simulate the manual input to fdisk
# The sed script strips off all the comments so that we can 
# document what we're doing in-line with the actual commands
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV}
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +100M # 100 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  a # make a partition bootable
  1 # bootable partition is partition 1 -- /dev/sda1
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

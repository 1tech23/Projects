#!/bin/bash
echo "Welcome to the Arch EasyInstall script."
echo "Created by Logan Alldredge, owner and proprietor of One Enterprises Tech."
echo -e "${RED}Warning: This will delete all data on a partition of your computer. Make sure to choose wisely when it is time to set up and delete partitions. Press ctrl + c to cancel this program at any time."
"I understand" = sig1
read -p "I understand the risks of running this program. I accept that the creator of this program cannot be held liable to any problems that this program may cause. To accept these statements, enter this statement word for word: I understand." statement
if ["$statement" = "$sig1" ] ; then
echo "Continuing with the program."
if else; then
echo "You did not accept the statements. Stopping program..."
done
read -p "Continue? Y or N" yn_1
case $yn_1 in
[Yy]* ) echo "Continuing.";;
[Nn]* ) done;;
* ) echo "Please answer yes or no.";;
esac
echo "This segment of this program is supposed to format and prepare disks for the installation of Arch Linux."
read -p "Please specify the name of disk to install Arch on. " disk
sfdisk -X gpt /dev/$disk <<EEOF 
,+500M,U,
,,L,
write   
EEOF

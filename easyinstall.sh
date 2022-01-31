#!/bin/bash
echo "Welcome to the Arch EasyInstall script."
echo "Created by Logan Alldredge, owner and proprietor of One Enterprises Tech."
echo -e "${RED}Warning: This will delete all data on a partition of your computer. Make sure to choose wisely when it is time to set up and delete partitions. Press ctrl + c to cancel this program at any time."
read -p "I understand the risks of running this program. I accept that the creator of this program cannot be held liable to any problems that this program may cause. Do you understand? Y or N" yn_1
echo "Continuing with the program."
case $yn_1 in
[Yy]* ) echo "Continuing the program.";;
[Nn]* ) echo "You did not accept the statements. Stopping program..."; done;;
esac
read -p "Continue? Y or N" yn_2
case $yn_2 in
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

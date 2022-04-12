#!/bin/bash

echo "Welcome to the Arch EasyInstall script."
echo "${RED}If you do not understand Linux filesystem commands (fdisk), do not continue. Press control + c to stop at any time."
echo "${RED}Since this program is new, commands are very delicate. When you enter a value, YOU MUST DOUBLE CHECK THE ANSWERS YOU MAKE! **deep voice** You have been warned... (-'_'-)"
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
[Nn]* ) echo "Stopping program..."; done;;
* ) echo "Please answer yes or no.";;
esac

echo "This segment of the installation process is for partitioning and setting up disks for the installation of Arch."
echo "Listing disks for use by user. Please choose a disk from the list to write Arch Linux to. Example: /dev/sda1. It is recommended that you write Arch Linux to your HDD/SSD."
fdisk -l
echo  "Select a disk to install Arch on. If you need to view the list again, quit this program (control+c) and run" 
echo "${GREEN}fdisk -l"
read -p "Choose your disk. Make sure to include the /dev before disk label. Disk name example: /dev/disk" disk_1
read -p "Is this the correct disk to write to? $disk_1 Yy or Nn Before you press Y or N, ensure that the disk name is in the format /dev/disk." yn_3

case $yn_3 in
[Yy]* ) echo "Continuing installation.";;
[Nn]* ) echo "You decided that $disk_1 is the wrong disk. To continue with this installer, run it again. Stopping program..."; done;;
* ) echo "You must choose either Y or N";;
esac

read -p "Installing Arch Linux to this drive will erase all data from the disk. Continue?" yn_4

case $yn_4 in
[Yy]* ) echo "Continuing installation. Beginning installation to $disk_1";;
[Nn]* ) echo "Stopping program..."; done;;
* ) echo "You must choose either Y or N.";;
esac

echo "The next few processes may take a while. Please be patient! Maybe have a coffee while your at it..."

while fdisk -w $disk_1
do
echo "Wiping $disk_1"
done
while
fdisk $disk_1 '
n
1

+512M
t
1
n
p
1


w
'
do
echo "Loading."
echo "Loading.."
echo "Loading..."
done

print -p "What is the name of the first partition? (Example: /dev/drivename1)" $disk_part1;
print -p "What is the name of the second partition? (Example: /dev/drivename2)" $disk_part2;
echo "${GREEN}$disk_part1 is the second partition. Make sure to include the /dev directory. Disk name example: /dev/sda1";
echo "${BLUE}$disk_part2 is the second partition. Make sure to include the /dev directory. Disk name example: /dev/sda2";
print -p "Are these the correct partitions of drive $disk_1?" yn_6

case $yn_6 in
[Yy]* ) echo "Continuing with the installation.";;
[Nn]* ) echo "Stopping the program. You must restart this program!";
echo "Stopping..."; done;;
* ) echo "Please answer yes or no.";;
esac

while mkfs.fat -F32 $disk_part1
do
echo "Activating $disk_part1 and writing as FAT32 filesystem..."
echo "Loading..."
done

while mkfs.ext4 $disk_part2
do 
echo "Activating $disk_part2 and writing as an EXT4 filesystem..."
echo "Loading..."
done

echo "The next segment is for setting up internet."
echo "A command will be run. Make sure you find your chip for internet. It will most likely be called wlan0. You might want to write it down."

iwctl '
device list
exit
'

read -p "What is the name of your network device, as shown on the list?" netdev_1
echo "Is $netdev_1 the correct device?" yn_7

case $yn_7 in
[Yy]* ) echo "Continuing with the program.";;
[Nn]* ) echo "Continuing..."; 
read -p "What is the name of your network device?" netdev_1 ;;
* ) echo "You must choose either Y or N."
esac

echo "Assuming that the program works the way that it is intended, you will now be presented with a list of newtworks to connect to. Choose the name of one. You may want to write it down."

iwctl '
station $netdev_1 scan
station $netdev_1 get-networks
'

read -p "What is the name of your network?" net_1
read -p "Is $net_1 the correct name of your network?" yn_8

case $yn_8 in
[Yy]* ) echo "Continuing with the program...";;
[Nn]* ) read -p "What is the name of your network?" net_1 ;;
* ) echo "You must choose either Y or N.";;
esac

echo "Continuing network setup. Make sure you know the password as well as the name of your network."
read -p "Does your network have a password?" yn_9

case $yn_9 in
[Yy]* ) read -p "What is the password?" net_password ;
iwctl '
station $netdev1 connect net_1
$net_password
station $netdev1 show
exit
'
;;
[Nn]* ) echo "Continuing network setup.";
iwctl '
station $netdev1 connect net_1
station $netdev1 show
exit
'
;;
* ) echo "You must choose either Y or N.";;
esac

echo "Hopefully your network is set up and connected. Cannot ping to Google without entering an infinite loop."
echo "The next segment will setup your file list. This file list is detrimental for installing anything. If you get an error message, restart the program (press control+c to stop it)"

while pacman -Syy
do
echo "Syncing files."
echo "Syncing files.."
echo "Syncing files..."
done

echo "Done syncing files."

while pacman -S reflector
do
echo "Adding mirror."
echo "Adding mirror.."
echo "Adding mirror..."
done

echo "Finished adding Reflector (mirror)"

while cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
do 
echo "Creating backup of mirror list."
echo "Creating backup of mirror list.."
echo "Creating backup of mirror list..."
done

echo "Finished creating mirror list backup."

read -p "What country are you from? (case sensitive, keep in caps)" country

while reflector -c "$country" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
do
echo "Saving mirror information to the mirror list."
echo "Saving mirror information to the mirror list.."
echo "Saving mirror information to the mirror list..."
done

echo "Finished adding info to mirror list."

echo "The next segment is for installing the system."

mount $disk_part2 /mnt

while pacstrap /mnt base linux linux-firmware vim nano
do
echo "Installing important base files."
echo "Installing important base files.."
echo "Installing important base files..."
done

echo "Done installing base files."

while genfstab -U /mnt >> /mnt/etc/fstab
do
echo "Generating filesystem table."
echo "Generating filesystem table.."
echo "Generating filesystem table..."
done

echo "Done generating fstab."
echo "Entering chroot."

arch-chroot /mnt

read -p "What is your timezone? Format example: US/Denver" timezone

timedatectl set-timezone $timezone

read -p "What langauge do you speak? (locale) Example: For American English, the locale is UTF-7. The most common format for American English is en_US.UTF-8" locale

locale-gen

echo LANG=$locale > /etc/locale.conf

export LANG=$locale

echo arch_user > /etc/hostname

read -p "What is your desired hostname? Leave blank to default as arch_user." hostname

echo $hostname > /etc/hostname

touch /etc/hosts

read -p "What is the password you want for root?" rootpasswd

passwd
$rootpasswd

echo "Now grub will begin to install."

pacman -S grub efibootmgr

mkdir /boot/efi

mount $disk_part1 /boot/efi

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

read -p "Does your computer use UEFI? Yy or Nn?" yn_5

case $yn_5 in
[Yy]* ) echo "Setting up GRUB for UEFI firmware";
pacman -S grub efibootmgr;
mkdir /boot/efi;
mount $disk_part1 /boot/efi;
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi;
grub-mkconfig -o /boot/grub/grub.cfg;;
[Nn]* ) echo "Setting up GRUB for non-UEFI firmware (Legacy).";
pacman -S grub;
grub-install $disk_1;
grub-mkconfig -o /boot/grub/grub.cfg;;
esac

read -p "Would you like to install a GUI? This will make it so that you can graphically run applications and such as opposed to running a non-graphical server." yynn_1

case $yynn_1 in
[Yy]* ) echo "Continuing with installation. This may take a while.";
read -p "What display manager or window manager would you like to use?" disman ;
pacman -S xorg ;
pacman -S $disman ;
systemctl start gdm.service ;
systemctl enable gdm.service ;
systemctl enable NetworkManager.service ;
echo "Installation finished.";
echo "${RED}You must remove installation medium now. Do it quickly.";
echo "${GREEN}The system will now exit chroot and shut down. Thank you for using the Arch EasyInstaller script! Visit https://oneneterprisestech.github.io/html/packages.html to view other packages for Linux."
exit;
shutdown now;;;
[Nn]* ) echo "Alright. That means that installation should be finished.";
echo "${RED}You must remove the installation medium. Do it quickly.";
reboot;;
* ) echo "You must choose Y or N.";;
esac

EOF

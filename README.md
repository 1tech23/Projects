# GitHub File Publishing Tool
Just bash it. Nothing else to do, other than you will have to choose a commit name.

# EasyInstaller
Note: Before running the program, the user _must_ set up WiFi.

To create and use Arch installer device:
Go to https://archlinux.org/download/ to download an ISO. Locate and choose your region.
Use an appropiate software to unpack the ISO image to an external device (USB, SD, Floppy, etc.) To unpack with
the Linux terminal, enter the command **dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync && sync**
Replase /dev/sdx with the path to the external device you will use for Arch Linux installation.
Plug the device into your computer, reboot computer, enter BIOS (press the buttons on the F row {F1 to F12} the button to enter the BIOS depends on the computer.  (make sure that secure boot is DISABLED), and select boot.

To set up WiFi in Arch:
Enter the following commands: 
wifi-menu -o
ip link (make sure you find the network interface name)
ip link set enp2s0f0 up (replace enp2s0f0 with your network interface name)
ip addr add 192.168.1.2/24 dev enp2s0f0 (replace 192.168.1.2/24 with your IP address and replace enp2s0f0 with your network interface name)
ip route add default via 192.168.1.1

To run, enter the EasyInstall script following commands after setting up internet:
cd; curl -LO oneenterprises.github.io/easyinstaller/easyinstaller.sh
sudo install -Dt /usr/local/bin -m 755 easyinstaller.sh
sudo easyinstaller.sh

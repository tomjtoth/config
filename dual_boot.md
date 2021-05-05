# disclaimer
this guide is really vague due to the ever changing world of IT, I'm too lazy to detail every single tiny step (updating this guide monthly)

# obtain installation images
 - windows
   - **use a non windows platform** to download the iso straight from [M$](www.microsoft.com/software-download)
 - linux
   - I use Arch Linux since I like to see how things work under the hood, but look around on [DS](distrowatch.com/)

# BIOS settings
go through all tabs in the BIOS and look for:
 - secure boot
   disable it
 - legacy boot
   enable it (this means you'll be able to boot in BIOS/MBR mode)
 - boot menu
   enable its hotkey
 - boot order
   set the primary disk of the machine as 1st

# prepare installation media
(2 USB sticks)
1. windows installer
 - works from windows only
   - use [rufus](rufus.ie)
   - select the target install medium
   - browse the downloaded ISO
   - leave everything at default
   - windows 10 iso
     - do not choose "Windows to Go"
1. linux installer
 - from linux
   - use `dd if=path/to/image.iso of=/path/to/blockdevice` or **etcher**
 - from windows
   - use [rufus](rufus.ie)

# boot target machine
 - BIOS or legacy-boot capable machines
   - boot via the boot menu just in case UEFI is higher prioritized than legacy
 - UEFI-only machines
   - it prefers GPT over MBR which takes up extra space
   - never had to use it thank God
   - this guide focuses on BIOS/MBR

# prepare partitions
 - order matters:
   read/write speeds in mechanical HDDs vary based on where the partition is located, the outer parts (beginning) of the disk is/are [faster](en.wikipedia.org/wiki/Circular motion#Velocity) therefore always install windows on the beginning of the disk (I tested 3 HDDs and they showed similar read/write speeds in the beginning/end of the disk)
 - BIOS mode
use fdisk to create a new DOS partition table on the disk

# Install windows
do **NOT allow internet** access during installation
select custom installation mode
delete the previously created 2 partitions
highlight the newly appeared unallocated area and click next/proceed (we're letting Windows create it as it sees fit)
do not enter a password for the primary user at this time
run cmd as admin and disable hibernation "powercfg /h off"
go to advanced performance settings and shrink the pagefile

# Install linux
Follow the Arch Linux install guide

# Optionally create a recovery image of windows
 - boot into linux
 - install clonezilla
 - sudo mkdir /home/partimag
 - capture all Windows related partitions
 - optionally test the image
   - format all Win10 partitions
   - restore the images to the partitions
 - reboot into Windows and allow internet access

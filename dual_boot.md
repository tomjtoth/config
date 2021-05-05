# Disclaimer
this guide is really vague due to the ever changing world of computers, there would be no point in detailing every single tiny step - update this guide monthly…

# Obtain installation image
## linux
select one from distrowatch.com, navigate to the websie of the disro and grab the latest release for your architecture
I prefer Arch Linux as it makes you more familiar with computers
## windows
open https://www.microsoft.com/software-download from android or linux, download the iso, then copy it to your current computer

# BIOS settings
go through all tabs in the BIOS and look for:
## secure boot
disable it
## legacy boot
enable it
this means you'll be able to boot in BIOS/MBR mode
## boot menu
enable F1..F12 hotkey
## boot order
set the primary disk of the machine as 1st

# prepare installation media
## windows installer
### from windows
use rufus.ie
select the target install medium
browse the downloaded ISO
leave everything at default
#### windows 10 iso
do not choose "Windows to Go"
## linux installer
### from linux
use dd or etcher
### from windows
use rufus.ie

# boot target machine
## BIOS or legacy-boot capable machines
## UEFI-only machines
prefers GPT over MBR which takes up extra space
never had to use it thank God

# prepare partitions
## order matters
read/write speeds in mechanical HDDs vary based on where the partition is located, the outer parts (beginning) of the disk is/are faster:
https://en.wikipedia.org/wiki/Circular motion#Velocity
therefore always install windows on the beginning of the disk (I tested 3 HDDs and they showed similar read/write speeds in the beginning/end of the disk)
## BIOS MBR
use fdisk to create a new DOS partition table on the disk
## UEFI GPT
I never do this as GPT takes up extra space...
use fdisk to create a new DOS partition table on the disk
probably create:
EFI boot partition first
then basic MS partition
then linux partition
then an NTFS equivalent data partition 

# Install windows
do not allow internet access at this time
do not enter a password for the primary user at this time
run cmd as admin and disable hibernation "powercfg /h off"
go to advanced performance settings and shrink the pagefile

# Install linux
Follow the Arch Linux install guide
Optionally create recovery image of windows
 - boot into linux
 - install clonezilla
 - sudo mkdir /home/partimag
 - capture all Windows related partitions
 - optionally test the image
   - format all Win10 partitions
   - restore the images to the partitions
 - reboot into Windows and allow internet access

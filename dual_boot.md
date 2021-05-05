# disclaimer
this guide is really vague due to the ever changing world of IT, I'm too lazy to detail every single tiny step (update this guide monthly)

# obtain the installation images
 - windows
   - **use a non-windows platform** to download the iso straight from [M$](https://www.microsoft.com/software-download)
 - linux
   - I use Arch Linux since I like to see how things work under the hood, but look around on [DS](https://distrowatch.com/)

# BIOS settings
go through all tabs in the BIOS and look for:
 - **secure boot** - disable it
 - **legacy boot** - enable it (this means you'll be able to boot in BIOS/MBR mode)
 - boot menu - enable its hotkey
 - boot order - set the primary disk of the machine as 1st  
there's a small change the machine is so old you won't find neither of the first 2 entries

# prepare the installation media
 - windows installer
   - works from windows only
     - use [rufus](https://rufus.ie)
     - select the target install medium
     - browse the downloaded ISO
     - leave everything at default
     - windows 10 iso
       - do not choose "Windows to Go"
 - linux installer
   - from linux - use `dd if=path/to/image.iso of=/path/to/blockdevice` or **etcher**
   - from windows - use rufus

# boot the target machine
 - boot via the boot menu just in case UEFI is higher prioritized than legacy

# prepare partitions
order matters:  
read/write speeds in mechanical HDDs vary based on where the partition is located, the outer parts (beginning) of the disk is/are [faster](https://en.wikipedia.org/wiki/Circular motion#Velocity) therefore always install windows on the beginning of the disk (I tested 3 HDDs and they showed similar read/write speeds in the beginning/end of the disk)  
use fdisk to create a new DOS partition table on the disk

# install windows
do **NOT allow internet** access during installation  
select custom installation mode  
delete the previously created 2 partitions  
highlight the newly appeared unallocated area and click next/proceed (we're letting Windows create it as it sees fit)  
do not enter a password for the primary user at this time  
run cmd as admin and disable hibernation "powercfg /h off"  
go to advanced performance settings and shrink the swap/pagefile

# install linux
always read the [ArchWiki](https://wiki.archlinux.org/title/installation_guide)  
while you're in `arch-chroot /mnt`:
   - `pacstrap /mnt at least networkmanager but better if all the possible packages you'll most probably use from the first boot on`
   - also `systemctl enable {NetworkManager,ntpd,etc services}` services, coz why not
   - also **create the primary user and add it to wheel/sudoers**

## my configuration
it changes quite often, I remember trying these Desktop Environemts:
 - LXDE - works well on weak hardware (required manual scripting of volume/brightness control at the time)
 - XFCE4 (usually works out of the box, on some laptops brightness control acted funny..)
 - gnome-shell on wayland - seemed quite bloated even without the real gnome package
 - sway (on wayland) most recently

# optionally create a recovery image of windows
 - install clonezilla in linux
 - `sudo mkdir /home/partimag`
 - capture all Windows related partitions (*/dev/sda{1,2}*)
 - (test the image)
   - format all Win10 partitions
   - restore the images to the partitions

# connect Windows to the internet
let it get the "best" drivers

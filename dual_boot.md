# disclaimer
this guide is really vague due to the ever changing world of IT, I'm too lazy to detail every single tiny step (update this guide monthly)

# obtain the installation images
 - windows
   - **use a non-windows platform** to download the iso straight from [M$](https://www.microsoft.com/software-download)
 - linux
   - I use [Arch Linux](https://archlinux.org/download/) since I like to see how things work under the hood, but look around on [DS](https://distrowatch.com/) to check out other distros

# BIOS settings
go through all tabs in the BIOS and look for:
 - **secure boot** (disable it)
 - **legacy boot** (enable it - this means you'll be able to boot in BIOS/MBR mode)
 - boot menu (enable its hotkey)
 - boot order (set the primary disk of the machine as 1st)
there's a small chance the machine is so old you won't find neither of the first 2 entries

# prepare the installation media
 - windows installer
   - works from windows only
     - use [rufus](https://rufus.ie)
     - select the target install medium
     - browse the downloaded ISO
     - leave everything at default
     - in case of windows 10 do not choose "Windows to Go"
 - linux installer
   - from linux\
     use `dd if=path/to/image.iso of=/path/to/blockdevice` or **etcher**
   - from windows\
     use rufus

# boot the target machine
boot via the boot menu just in case UEFI is higher prioritized than legacy

# prepare partitions
 - order matters:\
   read/write speeds in mechanical HDDs vary based on where the partition is located, the outer parts (beginning) of the disk is/are [faster](<https://en.wikipedia.org/wiki/Circular motion#Velocity>) therefore always install windows on the beginning of the disk (I tested 3 HDDs and they showed similar read/write speeds in the beginning/end of the disk)
 - use fdisk to
   - create a new DOS partition table on the disk
   - create 1st primary partition of 500MiB (for Windows bootloader)
   - create 2nd primary partition of ~80GiB (for Windows C:\)
   - create 3rd primary partition of ~30GiB (for linux /)
   - create 4th primary partition (not extended) for the rest of your data
   - change filesystem types to NTFS for partitions 1-2,4
   - write your changes
 - format partitions 
   - `mkfs.ntfs -Q /dev/sdX{1,2,4}`
   - `mkfs.ext4 /dev/sdX3`
 - reboot and start installing windows

# install windows
 - do **NOT allow internet access** during installation
 - select custom installation mode
 - delete the previously created partitions 1-2
 - **select/click/highlight the newly appeared unallocated area** and click next/proceed (we're letting Windows create partitions 1-2 as it sees fit)
 - when it looks like the install's ready
   - do not enter a password for the primary user
   - run cmd as admin and disable hibernation "powercfg /h off"
   - go to advanced performance settings and shrink the swap/pagefile

# install linux
 - always read the [ArchWiki](https://wiki.archlinux.org/title/installation_guide)
 - `pacstrap /mnt at least networkmanager intel-ucode or amd-ucode but better if all the possible packages you'll most probably use from the first boot on`
 - while you're chroot-ed
   - `systemctl enable {NetworkManager,ntpd,other_services_separated_by_comma}`
   - also **create the primary user and add it to wheel/sudoers**
   
## FOSS recommendations
 - I remember trying these Desktop Environemts:
   - LXDE - works well on weaker hardware (requires manual scripting of volume/brightness control at the time)
   - XFCE4 (usually works out of the box, on some laptops brightness control acted funny..)
   - gnome-shell on wayland - seemed quite bloated even without the real gnome package
   - sway (on wayland) started using this one most recently, takes a while to get used to tiling
 - emulators:
   - vice
   - dosbox
   - wine
   - virtualbox / qemu if you want to get your hands dirty
 - utilities:
   - ncdu
   - mc
   - htop
   - nano
   - wondershaper
 

# optionally create a recovery image of windows
 - boot into linux
 - `pacman -S clonezilla`
 - `sudo mkdir /home/partimag`
 - capture all Windows related partitions *(/dev/sda{1,2})*
 - *(test the image)*
   - *format all Win10 partitions*
   - *restore the images to the partitions*

# finish up Windows
 - connect to the internet
 - "check for updates"
 - leave it on for a few hours

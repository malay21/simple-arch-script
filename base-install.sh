
#!/usr/bin/env -S bash -e

#cleans tty window
clear

#checking cpu for microcode

CPU=$(grep vendor_id /proc/cpuinfo)
if [[ $CPU == *"AuthenticAMD"* ]]
then
    microcode=amd-ucode
else
    microcode=intel-ucode
fi

#base install
pacstrap /mnt base base-devel linux linux-firmware git vim $microcode

#copy 2nd script to installation drive
cp pakages-install.sh /mnt/pakages-install.sh

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt ./pakages-install.sh


#!/usr/bin/env -S bash -e

#cleans tty window
clear


#base install
pacstrap /mnt base base-devel linux linux-firmware git vim

#copy 2nd script to installation drive
cp pakages-install.sh /mnt/pakages-install.sh

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt ./pakages-install.sh

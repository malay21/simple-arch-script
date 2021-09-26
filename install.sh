
#!/usr/bin/env -S bash -e

#cleans tty window
clear

#base install
pacstrap /mnt base base-devel linux linux-firmware git vim amd-ucode
genfstab -U /mnt >> /mnt/etc/fstab

#enter chroot environment
arch-chroot /mnt
#set timezone
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

#setlanguage & networking
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
hostnamectl set-hostname linuxbox
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 linuxbox" >> /etc/hosts
echo root:123 | chpasswd

#plasma pakages
pacman -S bluez bluez-utils dolphin efibootmgr firefox firewalld grub konsole kget libappindicator-gtk3 networkmanager ntfs-3g plasma 

#nvidia pakages
pacman -S nvidia nvidia-utils

#grub-install
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable sddm NetworkManager bluetooth

useradd -m zirotu
echo zirotu:123 | chpasswd
usermod -aG wheel zirotu

#enter chroot environment
arch-chroot /mnt


#create swapfile
dd if=/dev/zero of=/swapfile bs=1M count=1024 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile  none  swap  defaults  0 0" >> /etc/fstab


#set timezone
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc


#setlanguage & networking
sed -i '177s/.//' /etc/locale.gen
locale-gen
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

#enable system services
systemctl enable sddm NetworkManager bluetooth

useradd -m zirotu
echo zirotu:123 | chpasswd
usermod -aG wheel zirotu

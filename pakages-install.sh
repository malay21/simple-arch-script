
#!/usr/bin/env -S bash -e

variables:
locale="en_US"
hname="linuxbox"
rootpaswd="123"
usrname="zirotu"
usrpasswd="123"


#cleans tty window
clear



#create swapfile
dd if=/dev/zero of=/swapfile bs=1M count=1024 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile  none  swap  defaults  0 0" >> /etc/fstab


#set timezone
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc


#setlanguage
echo "$locale.UTF-8 UTF-8"  > /mnt/etc/locale.gen
echo "LANG=$locale.UTF-8" > /mnt/etc/locale.conf

#networking
hostnamectl set-hostname $hname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hname" >> /etc/hosts
echo root:$rootpaswd | chpasswd


#plasma pakages
pacman -S --noconfirm bluez bluez-utils dolphin efibootmgr firefox firewalld grub konsole kget libappindicator-gtk3 networkmanager ntfs-3g plasma 


#nvidia pakages
pacman -S --noconfirm nvidia nvidia-utils


#grub-install
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#enable system services
systemctl enable sddm NetworkManager bluetooth

useradd -m $usrname
echo $usrname:$usrpasswd | chpasswd
usermod -aG wheel $usrname

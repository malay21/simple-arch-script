
#!/usr/bin/env -S bash -e

variables:
locale="en_US"
hname="linuxbox"
rootpaswd="123"
usrname="zirotu"
usrpasswd="123"
efidir="/boot/efi"
swapsize=1024
#cleans tty window
clear



#create swapfile
dd if=/dev/zero of=/swapfile bs=1M count=$swapsize status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile  none  swap  defaults  0 0" >> /etc/fstab


#set timezone
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc


#setlanguage
echo "$locale.UTF-8 UTF-8"  > /etc/locale.gen
echo "LANG=$locale.UTF-8" > /etc/locale.conf
locale-gen
#networking
hostnamectl set-hostname $hname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hname" >> /etc/hosts
echo root:$rootpaswd | chpasswd

#enable multilib for lutris
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Syy


#plasma pakages
pacman -S --noconfirm bluez bluez-utils dolphin efibootmgr firewalld grub konsole kget libappindicator-gtk3 networkmanager ntfs-3g plasma Spectacle


#nvidia pakages
pacman -S --noconfirm nvidia nvidia-utils nvidia-prime lib32-nvidia-utils


#grub-install
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=$efidir
grub-mkconfig -o /boot/grub/grub.cfg


#enable system services
systemctl enable sddm NetworkManager bluetooth firewalld

useradd -m $usrname
echo $usrname:$usrpasswd | chpasswd
usermod -aG wheel $usrname

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
#paru installation

git clone https://aur.archlinux.org/paru-bin /tmp && cd /tmp
su -c "makepkg -si" $usrname
exit
#selfdestruct after installation is complete
rm -- "$0"

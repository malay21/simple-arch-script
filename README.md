# simple-arch-script


arch script to setup very simple installation

dont run this script without changing variables according to your device don't blame me for any damage

- notes

  * network connection and partitioning should be done manually before running script
  * instead of using swap partition i have created swapfile by default with size of 1 GB
 ----------
 
  * my system partitions
    
      /dev/sda1 (boot) - 512 MB  - /mnt/boot/efi
      
      /dev/sda2 (/)    - 245 GB  - /mnt


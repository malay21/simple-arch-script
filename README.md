# simple-arch-script


arch script to setup very simple installation

dont run this script without changing variables according to your device don't blame me for any damage

----------

- how to use ?
  * after setting up network and partitions type this commands
   
        git clone https://github.com/malay21/simple-arch-script 
        
        cd simple-arch-script
        
        chmod +x *
        
        ./base-install.sh

- notes

  * network connection and partitioning should be done manually before running script
  * instead of using swap partition i have created swapfile by default with size of 1 GB

 ----------
 
  * my system partitions
    
    
        | partition | size | mount point |
        | --------- | ---- | ----------- |
        | /dev/sda1 (boot) | 512 MB  | /mnt/boot/efi |
        | /dev/sda2 (/)    | 245 GB  | /mnt |
    

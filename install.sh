
#!/usr/bin/env -S bash -e

#cleans tty window
clear

#Selecting a kernel to install. 

kernel_selector () {
    echo "List of kernels available: "
    echo "1) Stable (pakage:linux)              — Vanilla Linux kernel"
    echo "2) Hardened (pakage:linux-hardened)   — security-focused kernel."
    echo "3) Longterm (pakage:linux-lts)        — Long-term support (LTS) Linux kernel and modules."
    echo "4) Zen Kernel (pakage:linux-zen)      — Optimized for desktop usage."
    read -r -p "Insert the number of kernel: " choice
    echo "$choice is selected"
    case $choice in
        1 ) kernel=linux
            ;;
        2 ) kernel=linux-hardened
            ;;
        3 ) kernel=linux-lts
            ;;
        4 ) kernel=linux-zen
            ;;
        * ) echo "You did not enter a valid selection."
            kernel_selector
    esac
}

echo
echo "Welcome to swap file creator"
echo "https://github.com/nepgeargo/ubuntu-admin-toolkit"
echo "Here is the amount of memory and swap you have:"
echo
free -h

if [[ -f /swapfile ]]; then
    echo
    echo "It looks like you already have a swap file"
    echo
    echo "To remove it, run the following commands:"
    echo "$ swapoff /swapfile"
    echo "$ rm /swapfile"
    echo
    echo "If your swap file does not appear after a reboot, append the following line to /etc/fstab:"
    echo "/swapfile none swap sw 0 0"
    echo
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo
echo "This script creates a swap file and uses it as your swap"
echo "Below is Fedora's recommendation for the appropriate swap sizes:"
echo
echo "RAM         Swap        Swap with Hibernation"
echo "< 2 GB      2 * RAM     3 * RAM"
echo "2 - 8 GB    1 * RAM     2 * RAM"
echo "8 - 64 GB   0.5 * RAM   1.5 * RAM"
echo "> 8 GB      Min. 4GB    Not Recommended"

echo
read -p "How much swap do you want in MB? " SWAP_SIZE
echo
echo "Creating swap file"
echo
dd if=/dev/zero of=/swapfile count=$SWAP_SIZE bs=1M
ls / | grep swapfile
chmod 600 /swapfile
mkswap /swapfile

echo
echo "Swap file created. Turning it on"
echo
swapon /swapfile
echo "/swapfile none swap sw 0 0" >>/etc/fstab

echo "Please verify that swap is enabled"
echo
free -h

echo
echo "Please verify that /swapfile is appended to /etc/fstab"
echo
cat /etc/fstab
echo
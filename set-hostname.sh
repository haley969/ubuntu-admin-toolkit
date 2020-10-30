echo
echo "Welcome to the hostname configurator"
echo "This script will set your hostname and update the /etc/hosts file to reflect your new hostname"
echo "https://github.com/nepgeargo/ubuntu-admin-toolkit"

echo
echo "It is suggested that your hostname be unique, easily identifiable, and unrelated to the host's main purpose"
read -p "What would you like to use for your FQDN?: " FQDN
read -p "What would you like to use for your hostname?: " HOSTNAME

hostnamectl set-hostname $HOSTNAME
echo >> /etc/hosts
echo "# START ubuntu-admin-toolkit" >> /etc/hosts
echo "# https://github.com/nepgeargo/ubuntu-admin-toolkit" >> /etc/hosts
echo "127.0.0.1 $FQDN $HOSTNAME" >> /etc/hosts
echo "::1 $FQDN $HOSTNAME" >> /etc/hosts
echo "# END ubuntu-admin-toolkit" >> /etc/hosts

echo 
echo "Relogin to confirm the effects"
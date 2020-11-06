echo
echo "Welcome to the LDAP Client Installer"
echo "https://github.com/nepgeargo/ubuntu-admin-toolkit"

sudo apt update
sudo apt install ldap-auth-config libpam-ldap libnss-ldap ldap-auth-client -y

echo
read -p "Would you like to set up /etc/nsswitch.conf so the system will attempt to retrieve passwd, group, and hosts from LDAP? This will overwrite your existing config! (y/n): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

sudo cp config/nsswitch.conf /etc/nsswitch.conf

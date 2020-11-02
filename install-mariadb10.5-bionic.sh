echo
echo "Installing MariaDB"
echo

sudo apt install software-properties-common -y
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mariadb.mirror.digitalpacific.com.au/repo/10.5/ubuntu bionic main'
sudo apt update
sudo apt install mariadb-server -y

echo
echo "All installations completed"
read -p "Would you like to set up MariaDB now? (y/n): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo "Time to set up MariaDB!"
echo

sudo mysql_secure_installation

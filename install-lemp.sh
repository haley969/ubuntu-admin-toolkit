SECRET_FILE=~/.secrets/certbot/cloudflare.ini

echo
echo "Welcome to the LEMP Stack Installer"
echo "This script will also install Let's Encrypt certificates using Cloudflare DNS verification"
echo "Visit the EFF at https://certbot.eff.org"
echo "https://github.com/nepgeargo/ubuntu-admin-toolkit"

# Check the existence of Cloudflare API token secret file
if [[ ! -f "$SECRET_FILE" ]]; then
    echo "Please create a secret file containing your Cloudflare API token at $SECRET_FILE"
    echo "For more information visit https://certbot-dns-cloudflare.readthedocs.io/en/stable/"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Ask for domain names
echo "This information will be used for Let's Encrypt verification"
read -p "What's your root domain name?: " ROOT_DOMAIN
echo "It is suggested that your hostname be unique, easily identifiable, and unrelated to the host's main purpose"
echo "Hostname subdomains can be used for internal or testing purposes"
read -p "What's your hostname (not FQDN)?: " HOST_NAME

# Ask for confirmation
echo
read -p "Certificates will be issued for $ROOT_DOMAIN, *.$ROOT_DOMAIN, *.$HOST_NAME.$ROOT_DOMAIN. Would you like to continue? (y/n): " -n 1 -r

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo
echo "Installing prerequesites"
echo

sudo apt update
sudo snap install core
sudo snap refresh core
sudo apt-get install software-properties-common -y

echo "Installing MariaDB 10.5"
echo

sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mirror.rackspace.com/mariadb/repo/10.5/ubuntu focal main'
sudo apt update
sudo apt install mariadb-server -y

echo
echo "Installing NGINX"
echo

sudo apt install nginx -y

echo
echo "Installing PHP"
echo

sudo apt install php-fpm php-mysql php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-bcmath php-imagick -y

echo
echo "Installing Certbot"
echo

sudo apt remove certbot -y
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo snap set certbot trust-plugin-with-root=ok
sudo snap install certbot-dns-cloudflare

echo
echo "Requesting certificates"
certbot certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
    -d $ROOT_DOMAIN \
    -d *.$ROOT_DOMAIN \
    -d *.$HOST_NAME.$ROOT_DOMAIN

echo "Testing Certbot renewal"
echo
sudo certbot renew --dry-run

echo
echo "All installations completed"
echo "Time to set up MariaDB!"
echo

sudo mysql_secure_installation

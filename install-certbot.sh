SECRET_FILE=~/.secrets/certbot/cloudflare.ini
SECRET_PATH=~/.secrets/certbot

echo
echo "Welcome to the Certbot Installer"
echo "This script will install Let's Encrypt certificates using Cloudflare DNS verification"
echo "Visit the EFF at https://certbot.eff.org"
echo "https://github.com/nepgeargo/ubuntu-admin-toolkit"

# Check the existence of Cloudflare API token secret file
if [[ ! -f "$SECRET_FILE" ]]; then
    echo "Please modify the secret file at $SECRET_FILE so it contains your Cloudflare API token"
    echo "For more information visit https://certbot-dns-cloudflare.readthedocs.io/en/stable/"
    mkdir "$SECRET_PATH" -p
    touch "$SECRET_FILE"
    chmod 600 "$SECRET_FILE"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Ask for domain names
echo "This information will be used for Let's Encrypt verification"
read -p "What is your email address (used for urgent renewal and security notices)?: " ROOT_DOMAIN
read -p "What's your root domain name?: " ROOT_DOMAIN
echo "It is suggested that your hostname be unique, easily identifiable, and unrelated to the host's main purpose"
echo "Hostname subdomains can be used for internal or testing purposes"
read -p "What's your hostname (not FQDN)?: " HOST_NAME

# Ask for confirmation
echo
read -p "Certificates will be issued for $ROOT_DOMAIN, *.$ROOT_DOMAIN, *.$HOST_NAME.$ROOT_DOMAIN. Would you like to continue? (y/n): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo
echo "Installing prerequesites"
echo

sudo apt update
sudo apt install snapd -y
sudo snap install core
sudo snap refresh core
sudo apt-get install software-properties-common -y

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
-d *.$HOST_NAME.$ROOT_DOMAIN \
-m $ADMIN_EMAIL \
--agree-tos \
--non-interactive

echo "Testing Certbot renewal"
echo
sudo certbot renew --dry-run

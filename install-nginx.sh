RED='\033[0;31m'
NC='\033[0m'

SECRET_FILE=/root/.secrets/certbot/cloudflare.ini
SECRET_PATH=/root/.secrets/certbot

echo
echo "Welcome to the NGINX & PHP Installer"
echo

# Check the existence of Cloudflare API token secret file
if [[ ! -f "$SECRET_FILE" ]]; then
    echo -e "${RED}Please modify the secret file at $SECRET_FILE so it contains your Cloudflare API token${NC}"
    echo "For more information visit https://certbot-dns-cloudflare.readthedocs.io/en/stable/"
    echo
    mkdir "$SECRET_PATH" -p
    touch "$SECRET_FILE"
    chmod 600 "$SECRET_FILE"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

. scripts/config-certbot.sh

sudo apt update

echo
echo "Installing NGINX"
echo

sudo apt install nginx -y

echo
echo "Installing PHP"
echo

sudo apt install php-fpm php-mysql php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-bcmath php-imagick -y

. scripts/install-certbot.sh

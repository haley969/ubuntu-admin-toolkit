SECRET_FILE=/root/.secrets/certbot/cloudflare.ini
SECRET_PATH=/root/.secrets/certbot

echo
echo "Welcome to the NGINX & PHP Installer"
echo

. scripts/check-certbot-secret.sh
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

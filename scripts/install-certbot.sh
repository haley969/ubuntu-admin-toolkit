echo
echo "Installing Certbot prerequesites"
echo

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
    -d *.$HOST_NAME.$ROOT_DOMAIN

echo "Testing Certbot renewal"
echo
sudo certbot renew --dry-run
echo

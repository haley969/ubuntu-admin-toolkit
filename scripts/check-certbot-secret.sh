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

echo
echo "Welcome to Webmin installer"
echo "https://github.com/nepgeargo/ubuntu-admin-toolkit"
echo

echo >>/etc/apt/sources.list
echo "# START ubuntu-admin-toolkit" >>/etc/apt/sources.list
echo "# https://github.com/nepgeargo/ubuntu-admin-toolkit" >>/etc/apt/sources.list
echo "deb https://download.webmin.com/download/repository sarge contrib" >>/etc/apt/sources.list
echo "# END ubuntu-admin-toolkit" >>/etc/apt/sources.list

cd /tmp
wget https://download.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

apt update
apt install apt-transport-https -y
apt update
apt install webmin -y

sudo apt-get install software-properties-common -y
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mirror.rackspace.com/mariadb/repo/10.5/ubuntu focal main'
sudo apt update
sudo apt install mariadb-server -y

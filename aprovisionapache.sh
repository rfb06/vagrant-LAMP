#!/bin/bash
set -e

echo "Actualizando los repositorios"
sudo apt update -y
# Instalacion de dependencias
echo "Instalando apache, php, mysql, git y mariadb-client"
sudo apt install -y apache2 php libapache2-mod-php php-mysql git mariadb-client
cd /tmp
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
# copiar app a la carpeta de html
rm -r /var/www/html/*
cp -rf iaw-practica-lamp/src/* /var/www/html/
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Configuracion base de datps
sudo sed -i "s/define('DB_HOST'.*/define('DB_HOST', '10.20.30.6');/" /var/www/html/config.php
sudo sed -i "s/define('DB_NAME'.*/define('DB_NAME', 'lamp_db');/" /var/www/html/config.php
sudo sed -i "s/define('DB_USER'.*/define('DB_USER', 'uapp');/" /var/www/html/config.php
sudo sed -i "s/define('DB_PASSWORD'.*/define('DB_PASSWORD', 'papp');/" /var/www/html/config.php
systemctl restart apache2

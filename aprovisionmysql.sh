#!/bin/bash

set -e

DB_ROOT_PASS="toor"
DB_NAME="lamp_db"
DB_USER="uapp"
DB_PASS="papp"

echo "Actualiando los repositorios"
sudo apt update -y
sudo apt install -y mariadb-server
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl enable mariadb
systemctl start mariadb
mysql -u root <<CONF
alter user 'root'@'localhost' identified by '${DB_ROOT_PASS}';
create database if not exists ${DB_NAME};
create user if not exists '${DB_USER}'@'10.20.30.5' identified by '${DB_PASS}';
grant all privileges on ${DB_NAME}.* to '${DB_USER}'@'10.20.30.5';
flush privileges; 

use ${DB_NAME};
CREATE TABLE users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  age INT UNSIGNED NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CONF
sudo ip route del default 

# Reinicio de la base para aplicar cambios
sudo systemctl restart mariadb

echo "Servidor Mysql configurado correctamente"

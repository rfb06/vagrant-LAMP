# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  nombre="RicardoFrutos"

  config.vm.box = "debian/bookworm64"

  config.vm.define "#{nombre}Apache" do |apache|
    apache.vm.hostname = "#{nombre}Apache"
    apache.vm.network "forwarded_port", guest:80, host:8080
    apache.vm.network "private_network", ip: "10.20.30.5"
    apache.vm.provision "shell", path: "aprovisionapache.sh"
  
  end

  config.vm.define "#{nombre}Mysql" do |mysql|
    mysql.vm.hostname = "#{nombre}Mysql"
    mysql.vm.network "private_network", ip: "10.20.30.6"
    mysql.vm.provision "shell", path: "aprovisionmysql.sh"
  
  end
end

#!/bin/bash

# Auto installer webserver for debian 9
# @author: David Velasquez (http://jdavidvr.com | https://github.com/JDavidVR)

# Preconfig mariadb
echo -e "\e[96m Pre config mysql password  \e[39m"
sudo apt install debconf-utils -y;
sudo bash -c "debconf-set-selections <<< 'mariadb-server mysql-server/root_password password admin123';";
sudo bash -c "debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password admin123';";

# Install mariadb
echo -e "\e[96m Install Mariadb 10.2 \e[39m"
sudo apt install software-properties-common dirmngr -y;
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8;
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.ufscar.br/mariadb/repo/10.2/debian stretch main';
sudo apt update;
sudo apt install mariadb-server -y;

# Install php 7.1
echo -e "\e[96m Install PHP 7.1 \e[39m"
sudo apt install apt-transport-https ca-certificates -y;
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list;
sudo apt update;
sudo apt install php7.1-fpm php7.1-cli php7.1-bcmath php7.1-curl php7.1-gd php7.1-intl php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-xml php7.1-soap php7.1-xsl php7.1-zip php7.1-json php7.1-xdebug -y;
sudo phpenmod xdebug;

# Install apache
echo -e "\e[96m Install Apache2 \e[39m"
sudo apt install apache2 -y;
sudo apt install libapache2-mod-fcgid -y;
sudo a2enmod rewrite proxy_fcgi;
sudo a2enconf php7.1-fpm;
sudo service apache2 restart;

# Change apache and php-fpm users and groups ***
echo -e "\e[96m Change Apache and Php-Fpm user owner \e[39m"
sudo sed -i.BAK "s;www-data;vagrant;" /etc/apache2/envvars;
sudo sed -i.BAK "s;www-data;vagrant;" /etc/php/7.1/fpm/pool.d/www.conf;
sudo service apache2 restart;
sudo service php7.1-fpm restart;

# Change /var/www owner
sudo chown -R vagrant:vagrant /var/www/;

#phpmyadmin: will be implemented in future

# Install Composer
echo -e "\e[96m Install Composer \e[39m"
sudo wget https://getcomposer.org/download/1.6.5/composer.phar -O /usr/local/bin/composer;
sudo chmod +x /usr/local/bin/composer;

# Install Magerun2
echo -e "\e[96m Install Magerun2 \e[39m"
sudo wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/mr2;
sudo chmod +x /usr/local/bin/mr2;

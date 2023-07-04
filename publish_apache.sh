#!/bin/bash

read -p "Введите имя публикации: " publish_name
read -p "Введите имя сервера: " server_name
read -p "Введите имя базы: " base_name

cd /opt/1cv8/x86_64/8.3.19.1726/
sudo ./webinst -publish -confpath /etc/apache2/apache2.conf -apache24 -wsdir $publish_name -dir /var/www/$publish_name -connstr “Srvr=$server_name;Ref=$base_name”
cd ~
systemctl restart apache2

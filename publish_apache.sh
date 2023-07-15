#!/bin/bash

read -p "Вы хотите создать публикацию(y/n): " var
if ["$var == y"];then
	read -p "Введите имя публикации: " publish_name
	read -p "Введите имя сервера: " server_name
	read -p "Введите имя базы: " base_name
	
	cd /opt/1cv8/x86_64/*/
	sudo ./webinst -publish -confpath /etc/apache2/apache2.conf -apache24 -wsdir $publish_name -dir /var/www/$publish_name -connstr “Srvr=$server_name;Ref=$base_name”
	read -p "Напишите правильный путь к информационной базе" aaa
	nano /var/www/$publish_name/*.vrd
	cd ~
	systemctl restart apache2
fi
	
if ["$var == n"];then
	read -p "Вы хотите создать публикацию(y/n): " var
	
	if ["$var == y"];then

		read -p "Введите имя публикации: " publish_name
		read -p "Введите имя сервера: " server_name
		read -p "Введите имя базы: " base_name
	
		cd /opt/1cv8/x86_64/*/
		sudo ./webinst -delete -confpath /etc/apache2/apache2.conf -apache24 -wsdir $publish_name -dir /var/www/$publish_name -connstr “Srvr=$server_name;Ref=$base_name”
		cd ~
		systemctl restart apache2
	fi
fi



# !/bin/bash
#
#
# Установка Firewall
#
#
 apt-get install -y iptables
#
read -p "Выключите параметр IPV6" help 
nano /etc/default/ufw  
systemctl enable ufw	# добавление сервиса ufw в автозагрузку
systemctl start ufw		# запуск сервиса ufw
#
ufw allow 22/tcp		# для ssh
#
iptables -A INPUT -p tcp -m state --state NEW --dport 5432 -s 10.1.50.0/24 -j ACCEPT
ufw allow 1540/tcp		# для агента сервера
ufw allow 1541/tcp		# для менеджера кластера
ufw allow 1560:1591/tcp # для рабочих процессов
#
ufw allow 5432/tcp 		# для СУБД
#
ufw allow 433/tcp 		# для веб-сервера Apache
#
systemctl restart uwf	# перезагрузка сервиса ufw
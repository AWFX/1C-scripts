# !/bin/bash
#
#
# Установка PostgreSQL
#
#
wget https://repo.postgrespro.ru/1c-13/keys/pgpro-repo-add.sh 		# Получение скрипта, который добавляет репозитории
sh pgpro-repo-add.sh 
#
apt-get install postgrespro-1c-13									# установка СУБД PostgreSQL
rm -rf pgpro-repo-add.sh											# удаление скрипта
#
rm -rf /var/lib/pgpro/1c-13/data/ 									# удаление тестовой базы данных
/opt/pgpro/1c-13/bin/pg-setup initdb --tune=1c --locale=ru_RU.UTF-8 # инициализация новой базы с нужными параметрами
#
read -p "Введите пароль для пользователя postgres" pass;
su - postgres
psql
ALTER USER postgres WITH ENCRYPTED PASSWORD $pass;
\q
exit
#
read -p "Введите адрес сети: " ip_network
echo "host all all $ip_network md5" >> /var/lib/pgpro/1c-13/data/pg_hba.conf
#
#
systemctl enable postgrespro-1c-13 									# добавление PostgreSQL в автозагрузку
systemctl start postgrespro-1c-13									# запуск PostgreSQL
#
#
# Установка 1С Сервера
#
#
apt-get install -y ttf-mscorefonts-installer		# установка шрифтов, необходимых для корректной работы
fc-cache –fv										# обновление шрифтов системы
#
apt-get install -y libfreetype6 libgsf-1-common unixodbc glib2.0 libgtk-3-0 lcms2 libc6:i386 # установка необходимых компонентов
#
mount /dev/sdb /mnt 		# монтирование флешки с архивом
#
tar -xzvf /mnt/*.tar.gz		# распаковка архива
rm -rf /mnt/*nls*.deb		# удаление ненужных пакетов

dpkg -i /mnt/*.deb			# установка пакетов
#
ln -s /opt/1cv8/x86_64/*/srv1cv83 /etc/init.d/srv1cv83	# создание сивольной ссылки, для удобного обращения к сервису 1С
#
systemctl enable /opt/1cv8/x86_64/*/srv1cv83 			# добавление серсиса в автозагрузку
systemctl start /opt/1cv8/x86_64/*/srv1cv83				# запуск сервиса 1С
#
rm -rf /mnt/*.deb		# удаление пакетов
umount /dev/sdb /mnt	# монтирование флешки с архивом
#
#
# Установка HASP
#
#
wget https://download.etersoft.ru/pub/Etersoft/HASP/stable/x86_64/Ubuntu/22.04/haspd_8.53-eter1ubuntu_amd64.deb # получение пакетов 
#
dpkg -i *.deb 			# установка пакетов
#
systemctl enable haspd	# добавление сервиса HASP в автозагрузку
systemctl start haspd	# запуск сервиса HASP
#
rm -rf *.deb			# удаление пакетов
#
#
# Установка Firewall
#
#
apt install -y ufw 		# установка Firewall
systemctl enable ufw	# добавление сервиса ufw в автозагрузку
systemctl start ufw		# запуск сервиса ufw
#
ufw allow 22/tcp		# для ssh
#
ufw allow 1540/tcp		# для агента сервера
ufw allow 1541/tcp		# для менеджера кластера
ufw allow 1560:1591/tcp # для рабочих процессов
#
ufw allow 5432/tcp 		# для СУБД
#
ufw allow 433/tcp 		# для веб-сервера Apache
#
systemctl restart uwf	# перезагрузка сервиса ufw
#
#
# Установка Apache2
#
#
apt install -y apache2		
systemctl enable apache2 	# добавление веб-сервера в автозагрузку
systemctl start apache2 	# запуск веб-сервера
#
#
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout .key -out .crt	# создание самоподписанного сертификата на год
cd /etc/apache2/sites-available
read -p "Пропишите название вашего сертификата" help
nano  000-default.conf
sudo a2enmod ssl	# проверка корректности сертификата

read -p "Пропишите имя вашего сервера" help
nano /etc/apache2/sites-available/apache2.conf
 
 
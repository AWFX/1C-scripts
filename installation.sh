# !/bin/bash
#
#
# Установка PostgreSQL
#
#
wget https://repo.postgrespro.ru/1c-12/keys/pgpro-repo-add.sh 		# Получение скрипта, который добавляет репозитории
sh pgpro-repo-add.sh
#
apt-get install -y postgrespro-1c-12								# установка СУБД PostgreSQL
rm -rf pgpro-repo-add.sh											# удаление скрипта
#
rm -rf /var/lib/pgpro/1c-12/data/ 									# удаление тестовой базы данных
/opt/pgpro/1c-12/bin/pg-setup initdb --tune=1c --locale=ru_RU.UTF-8 # инициализация новой базы с нужными параметрами
rm -f /var/lib/pgpro/1c-12/data/postgresql.conf						# удаление старого файла конфигураций
mv ~/postgresql.conf /var/lib/pgpro/1c-12/data/ 					# перемещение нового файла конфигураций
#
#
systemctl enable postgrespro-1c-12									# добавление PostgreSQL в автозагрузку
systemctl start postgrespro-1c-12									# запуск PostgreSQL
#
#
# Установка 1С Сервера
#
#
apt-get install -y ttf-mscorefonts-installer		# установка шрифтов, необходимых для корректной работы
fc-cache –fv										
#
apt-get install -y libfreetype6 libgsf-1-common unixodbc glib2.0 libgtk-3-0 liblcms2-2 libc6-dev-i386 # установка необходимых компонентов
#
mount /dev/sdb /mnt 		# монтирование флешки с архивом
#
tar -xzvf /mnt/*.tar.gz		# распаковка архива
rm -rf /mnt/*nls*.deb		# удаление ненужных пакетов
#
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
# Установка Apache2
#
#
apt install -y apache2		
systemctl enable apache2 	# добавление веб-сервера в автозагрузку
systemctl start apache2 	# запуск веб-сервера
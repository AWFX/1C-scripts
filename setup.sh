#!/bin/bash


# Установка вспомогательных компонентов


apt-get update						# обновление пакетов

apt install -y nano			# утилита для удобного просмотра и редактирования файлов
apt install -y wget			# утилита для получения файлов из интернета
apt-get install -y locales	# утилита, благодаря которой, можно установить нужную локаль


# Установка локали


# Установка PostgreSQL


wget https://repo.postgrespro.ru/1c-13/keys/pgpro-repo-add.sh 		# Получение скрипта, который добавляет репозитории
sh pgpro-repo-add.sh 

apt-get install postgrespro-1c-13									# установка СУБД PostgreSQL
rm -rf pgpro-repo-add.sh											# удаление скрипта

rm -rf /var/lib/pgpro/1c-13/data/ 									# удаление тестовой базы данных
/opt/pgpro/1c-13/bin/pg-setup initdb --tune=1c --locale=ru_RU.UTF-8 # инициализация новой базы с нужными параметрами

systemctl enable postgrespro-1c-13 									# добаление PostgreSQL в автозагрузку


# Установка 1С Сервера


#apt-get install -y ttf-mscorefonts-installer		# установка шрифтов, необходимых для корректной работы
#fc-cache –fv										# обновление шрифтов системы

#apt-get -y install libfreetype6 libgsf-1-common unixodbc glib2.0 libgtk-3-0 lcms2 # установка необходимых компонентов


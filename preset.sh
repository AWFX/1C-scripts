# !/bin/bash
#
#
# Установка правильного времени для региона Тюмень
#
#
timedatectl set-timezone Asia/Yekaterinburg
#
#
# Установка вспомогательных компонентов
#
#
apt-get update				# обновление пакетов
#
apt install -y nano			# утилита для удобного просмотра и редактирования файлов
apt install -y wget			# утилита для получения файлов из интернета
apt-get install -y locales		# утилита для настройки локали
#
#
# Установка локали
#
#
read -p "Choose russian locale - 392 and english locale - 160 " help
dpkg-reconfigure locales

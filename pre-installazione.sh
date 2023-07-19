# !/bin/bash
#
#
# Установка правильного времени для региона Тюмень
#
#
timedatectl set-timezone Asia/Yekaterinburg
#
# Установка вспомогательных компонентов
#
#
apt-get update				# обновление пакетов
#
apt install -y nano			# утилита для удобного просмотра и редактирования файлов
apt install -y wget			# утилита для получения файлов из интернета
apt-get install -y locales	# утилита для настройки локали
#
#
# Установка локали
#
#
dpkg-reconfigure locales
#
#
# Решаем проблему a start job is running for wait for network to be configured 
#
#
read -p "допишите параметр optional=true, для каждого сетевого адаптера: " help
nano /etc/netplan/*.yaml

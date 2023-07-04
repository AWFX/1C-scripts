#!/bin/bash


wget https://repo.postgrespro.ru/1c-15/keys/pgpro-repo-add.sh
sh pgpro-repo-add.sh
apt-get install postgrespro-1c-15

rm -rf /var/lib/pgpro/1c-15/data/
/opt/pgpro/1c-15/bin/pg-setup initdb --tune=1c --locale=ru_RU.UTF-8
systemctl enable postgrespro-1c-15

read -p "Введите адрес сети: " ip_network
echo "host all all $ip_network md5" >> /var/lib/pgpro/1c-15/data/pg_hba.conf
systemctl restart postgrespro-1c-15
cd
rm -rf pgpro-repo-add.sh

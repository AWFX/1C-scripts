#!/bin/bash

apt-get -y install ttf-mscorefonts-installer
fc-cache –fv

apt-get -y install libfreetype6 libgsf-1-common unixodbc glib2.0

mount /dev/sdb /mnt
cd /mnt

cp deb64_8_3_19_1726.tar.gz ~
cd ~
tar -xzvf deb64_8_3_19_1726.tar.gz

dpkg -i *.deb

ln -s /opt/1cv8/x86_64/8.3.19.1726/srv1cv83 /etc/init.d/srv1cv83

systemctl start /opt/1cv8/x86_64/8.3.19.1726/srv1cv83


#hasp

cd ~
mkdir hasp

cd hasp
wget https://download.etersoft.ru/pub/Etersoft/HASP/stable/x86_64/Ubuntu/22.04/haspd_8.53-eter1ubuntu_amd64.deb
apt-get -y install libc6:i386
dpkg -i *.deb
systemctl start haspd

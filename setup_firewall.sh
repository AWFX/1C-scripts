#!/bin/bash

apt install -y ufw

# /etc/default/ufw

# for ssh
ufw allow 22/tcp

#for 1C
ufw allow 1540/tcp
ufw allow 1541/tcp
ufw allow 1560:1591/tcp

#for Postgres
ufw allow 5432/tcp

#for Apache
ufw allow 433/tcp

systemctl enable ufw
systemctl start ufw

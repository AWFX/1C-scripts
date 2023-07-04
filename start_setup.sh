#!/bin/bash

apt-get update

apt install -y nano
apt install -y wget
apt-get install -y locales

apt install -y apache2

dpkg-reconfigure locales

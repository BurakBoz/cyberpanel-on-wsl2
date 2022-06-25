#!/usr/bin/env bash

cd /root || exit
yum install epel-release -q -y && yum -y -q update && yum upgrade -y -q
dnf install python2 -y
ln -s /usr/bin/python2 /usr/bin/python

echo "Installing distrod (systemd for WSL2)"
curl -L -O "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh"
chmod +x install.sh
sudo ./install.sh install
/opt/distrod/bin/distrod enable
echo "systemd installed."

yum -y -q install htop hostname cronie nano wget curl sudo tmpwatch openssh-server
cd /root || exit

rm -f install.sh
wget -O install.sh https://cyberpanel.net/install.sh
chmod +x install.sh
./install.sh

echo "Upgrading php-cli to 8.1"
rm -f /usr/bin/phpSys
mv /usr/bin/php /usr/bin/phpSys
ln -s /usr/local/lsws/lsphp81/bin/php /usr/bin/php

echo "symlinking php versions like php56 php74 php81 etc"
echo "you can use those php symlinks for running shortly custom php version on cli. like;"
echo "php74 composer.phar install"
echo "php81 test.php"
echo "and so on.."

ln -s /usr/local/lsws/lsphp56/bin/php /usr/bin/php56
ln -s /usr/local/lsws/lsphp70/bin/php /usr/bin/php70
ln -s /usr/local/lsws/lsphp71/bin/php /usr/bin/php71
ln -s /usr/local/lsws/lsphp72/bin/php /usr/bin/php72
ln -s /usr/local/lsws/lsphp73/bin/php /usr/bin/php73
ln -s /usr/local/lsws/lsphp74/bin/php /usr/bin/php74
ln -s /usr/local/lsws/lsphp80/bin/php /usr/bin/php80
ln -s /usr/local/lsws/lsphp81/bin/php /usr/bin/php81
ln -s /usr/local/lsws/lsphp82/bin/php /usr/bin/php82

yum install -q -y lsphp70 lsphp70-xml lsphp70-zip lsphp70-json lsphp70-pdo lsphp70-opcache lsphp70-mbstring lsphp70-intl lsphp70-gd lsphp70-mcrypt lsphp70-pecl-redis lsphp70-bcmath lsphp71 lsphp71-xml lsphp71-zip lsphp71-json lsphp71-pdo lsphp71-opcache lsphp71-mbstring lsphp71-intl lsphp71-gd lsphp71-mcrypt lsphp71-pecl-redis lsphp71-bcmath lsphp72 lsphp72-xml lsphp72-zip lsphp72-json lsphp72-pdo lsphp72-opcache lsphp72-mbstring lsphp72-intl lsphp72-gd lsphp72-mcrypt lsphp72-pecl-redis lsphp72-bcmath lsphp73 lsphp73-xml lsphp73-zip lsphp73-json lsphp73-pdo lsphp73-opcache lsphp73-mbstring lsphp73-intl lsphp73-gd lsphp73-mcrypt lsphp73-pecl-redis lsphp73-bcmath lsphp74 lsphp74-xml lsphp74-zip lsphp74-json lsphp74-pdo lsphp74-opcache lsphp74-mbstring lsphp74-intl lsphp74-gd lsphp74-mcrypt lsphp74-pecl-redis lsphp74-bcmath
yum install -q -y lsphp73 lsphp73-bcmath lsphp73-common lsphp73-devel lsphp73-gd lsphp73-gmp lsphp73-intl lsphp73-json lsphp73-mbstring lsphp73-mysqlnd lsphp73-opcache lsphp73-pdo lsphp73-pear lsphp73-pecl-igbinary lsphp73-pecl-mcrypt lsphp73-pecl-memcached lsphp73-pecl-msgpack lsphp73-pecl-redis lsphp73-pgsql lsphp73-process lsphp73-pspell lsphp73-recode lsphp73-xml lsphp73-xmlrpc lsphp73-zip
yum install -q -y lsphp74 lsphp74-bcmath lsphp74-common lsphp74-devel lsphp74-gd lsphp74-gmp lsphp74-intl lsphp74-json lsphp74-mbstring lsphp74-mysqlnd lsphp74-opcache lsphp74-pdo lsphp74-pear lsphp74-pecl-igbinary lsphp74-pecl-mcrypt lsphp74-pecl-memcached lsphp74-pecl-msgpack lsphp74-pecl-redis lsphp74-pgsql lsphp74-process lsphp74-pspell lsphp74-xml lsphp74-xmlrpc lsphp74-zip
yum install -q -y lsphp80 lsphp80-bcmath lsphp80-common lsphp80-devel lsphp80-gd lsphp80-gmp lsphp80-intl lsphp80-json lsphp80-mbstring lsphp80-mysqlnd lsphp80-opcache lsphp80-pdo lsphp80-pear lsphp80-pecl-igbinary lsphp80-pecl-memcached lsphp80-pecl-msgpack lsphp80-pecl-redis lsphp80-pgsql lsphp80-process lsphp80-pspell lsphp80-xml lsphp80-zip
yum install -q -y lsphp81 lsphp81-bcmath lsphp81-common lsphp81-devel lsphp81-gd lsphp81-gmp lsphp81-intl lsphp81-json lsphp81-mbstring lsphp81-mysqlnd lsphp81-opcache lsphp81-pdo lsphp81-pgsql lsphp81-process lsphp81-pspell lsphp81-xml lsphp81-zip

echo "Adding tmpwatch to cronjob."
cronStr="0 0 * * * root tmpwatch --mtime --all 24 /tmp >/dev/null 2>&1" && sudo crontab -l > /tmp/currentCrons || true && echo "$cronStr" >> /tmp/currentCrons && sudo crontab /tmp/currentCrons

echo "Adding package update to cronjob."
cronStr="15 2 * * * root yum -y -q update && yum upgrade -y -q >/dev/null 2>&1" && sudo crontab -l > /tmp/currentCrons || true && echo "$cronStr" >> /tmp/currentCrons && sudo crontab /tmp/currentCrons

echo "Adding automatic upgrade cronjob for cyberpanel."
cronStr="0 5 * * * root sh <(curl https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh || wget -O - https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh) >/dev/null 2>&1" && sudo crontab -l > /tmp/currentCrons || true && echo "$cronStr" >> /tmp/currentCrons && sudo crontab /tmp/currentCrons

echo "Adding automatic restart cronjob for lscpd."
cronStr="0 3 * * * root systemctl restart lscpd >/dev/null 2>&1" && sudo crontab -l > /tmp/currentCrons || true && echo "$cronStr" >> /tmp/currentCrons && sudo crontab /tmp/currentCrons
cronStr="@reboot root systemctl restart lscpd >/dev/null 2>&1" && sudo crontab -l > /tmp/currentCrons || true && echo "$cronStr" >> /tmp/currentCrons && sudo crontab /tmp/currentCrons

echo "Adding automatic restart cronjob for lsws."
cronStr="0 3 * * * root systemctl restart lsws >/dev/null 2>&1" && sudo crontab -l > /tmp/currentCrons || true && echo "$cronStr" >> /tmp/currentCrons && sudo crontab /tmp/currentCrons
cronStr="@reboot root systemctl restart lsws >/dev/null 2>&1" && sudo crontab -l > /tmp/currentCrons || true && echo "$cronStr" >> /tmp/currentCrons && sudo crontab /tmp/currentCrons

echo "Adding .DS_Store cleaner to cronjob."
cronStr="15 1 * * * root find / -name \".DS_Store\" -type f -delete  >/dev/null 2>&1" && sudo crontab -l > /tmp/currentCrons || true && echo "$cronStr" >> /tmp/currentCrons && sudo crontab /tmp/currentCrons

echo 127.0.0.1 > /etc/cyberpanel/machineIP
systemctl enable lscpd
systemctl enable lsmcd
systemctl enable lsws
systemctl enable crond
systemctl enable redis

echo "Installation completed. rebooting now.."

reboot
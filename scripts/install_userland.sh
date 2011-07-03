#!/bin/sh


############
### Ports ###
############

cd /usr/ports/devel/libtool ; make install clean
cd /usr/ports/databases/db41 ; make install clean
cd /usr/ports/converters/libiconv ; make install clean
cd /usr/ports/devel/gettext ; make install clean
cd /usr/ports/devel/autoconf-wrapper ; make install clean
cd /usr/ports/devel/gmake ; make install clean
# Ports manager
cd /usr/ports/ports-mgmt/portupgrade ; make config-recursive ; make fetch-recursive ; make install clean
# managepkg portmaster

portupgrade -N lang/gcc46

# fetch all
# portupgrade -N -c -F php5 php5-bsdconv php5-bz2 php5-ctype php5-filter php5-gd php5-iconv php5-mbstring php5-mcrypt php5-mysql php5-openssl php5-session php5-xml php5-zip php5-zlib p5-Authen-Libwrap p5-IO-Tty p5-libwww p5-Net-OpenSSH p5-Net-SSH2 p5-Net-SSLeay p5-perl-ldap p5-String-Multibyte p5-Mail-SpamAssassin krb5 bind96 xorg xorg-drivers liberation-fonts-ttf xfe xfce samba35 samba35-libsmbclient pam_smb mysql-client mysql-server mysql-scripts lighttpd webmin usermin phpvirtualbox phpmyadmin webalizer bash aircrack-ng virtualbox-ose virtualbox-ose-additions iperf firefox firefox-i18n chromium bsdconv openssl openldap-client nss ca_root_nss nss_mdns gzip  fetchmail procmail   libnss-mysql pam_mysql clean gnupg logrotate proftpd proftpd-mysql screen smartmontools      

# install all
# portupgrade -N gcc php5 perl python ruby php5-bsdconv php5-bz2 php5-ctype php5-filter php5-gd php5-iconv php5-mbstring php5-mcrypt php5-mysql php5-openssl php5-session php5-xml php5-zip php5-zlib p5-Authen-Libwrap p5-IO-Tty p5-libwww p5-Net-OpenSSH p5-Net-SSH2 p5-Net-SSLeay p5-perl-ldap p5-String-Multibyte p5-Mail-SpamAssassin krb5 bind96 xorg xorg-drivers liberation-fonts-ttf xfe xfce samba35 samba35-libsmbclient pam_smb mysql-client mysql-server mysql-scripts apache lighttpd webmin usermin phpvirtualbox phpmyadmin webalizer bash aircrack-ng virtualbox-ose virtualbox-ose-additions iperf firefox firefox-i18n chromium bsdconv openssl openldap-client nss ca_root_nss nss_mdns gzip  fetchmail procmail   libnss-mysql pam_mysql clean gnupg logrotate proftpd proftpd-mysql screen smartmontools      

# java

# post install scripts
#cd /sys_tank/usr/local/etc/hal/fdi/policy/ ; fetch http://chez.tinico.free.fr/docs/bsd.conf/x11-input.fdi
#Xorg -configure
#mv xorg.conf.new /etc/X11/xorg.conf
#/usr/local/lib/webmin/setup.sh


############
### Packages ###
############


# C Tools & autres utils
pkg_add -r bsdconv libtool db41 libiconv gettext autoconf-wrapper gmake gcc46 pcre libsigc++ libcheck eject hal



############
### Web ###
############

# mySQL
pkg_add -r cmake mysql55-client mysql55-server mysql-scripts pam-mysql libnss-mysql 
cd /usr/local/bin
mysql_install_db --user=mysql --basedir=/usr/local --databasedir=/var/db/mysql
touch /var/log/mysqld.log
cd /usr/local/etc/
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/my.conf

# Apache
pkg_add -r apache22 ap22-mod_security
cd /usr/local/etc/apache22/
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/httpd.conf
#cd /usr/local/www/
cp -Rlp /usr/local/www/apache22/cgi-bin /usr/local/www
cp -Rlp /usr/local/www/apache22/error /usr/local/www
cp -Rlp /usr/local/www/apache22/html /usr/local/www
cp -Rlp /usr/local/www/apache22/icons /usr/local/www
cp -Rlp /usr/local/www/apache22/usage /usr/local/www
rm -r /usr/local/www/apache22

# PHP 5
pkg_add -r php5 php5-bsdconv php5-bz2 php5-ctype php5-filter php5-gd php5-iconv php5-json php5-mbstring php5-mcrypt php5-mysql php5-openssl php5-session php5-xml php5-zip php5-zlib

# Perl 5
pkg_add -r p5-DBD-mysql55 p5-Authen-Libwrap p5-IO-Tty p5-libwww p5-Net-OpenSSH p5-Net-SSH2 p5-Net-SSLeay p5-perl-ldap p5-String-Multibyte p5-Mail-SpamAssassin

# Ruby
pkg_add -r ruby

##############
### Divers ###
##############

# VirtualBox
pkg_add -r virtualbox-ose

pw groupmod operator -m lordzurp
echo "[system=10]" >> /etc/devfs.rules
echo "add path 'usb/*' mode 0660 group operator" >> /etc/devfs.rules

# vboxtool
cd /usr/local/bin
fetch https://raw.github.com/lordzurp/Zurpatator2/master/scripts/vboxtool/vboxtool
chmod +x vboxtool
cd /usr/local/etc/rc.d
fetch https://raw.github.com/lordzurp/Zurpatator2/master/scripts/vboxtool/vboxtoolinit
chmod +x vboxtoolinit
mkdir /usr/local/etc/vboxtool
echo "HomeBack" > /usr/local/etc/vboxtool/machines.conf
echo "vbox_user='vboxusers'" > /usr/local/etc/vboxtool/vboxtool.conf


# Samba
pkg_add -r samba35 samba35-libsmbclient pam_smb
cd /usr/local/etc
mv smb.conf smb.conf.dist
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/smb.conf
chmod 644 smb.conf
cd /etc
ln -s ../usr/local/etc/smb.conf
ln -s ..//usr/local/etc/samba
cd rc.d
ln -s ../../usr/local/etc/rc.d/samba
read -p "pensez � ajouter les membres des groupes 1000 et 1001 dans samba via webmin :)"

# Netatalk
pkg_add -r netatalk
cd /usr/local/etc/
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/afpd.conf
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/netatalk.conf
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/AppleVolumes.default
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/AppleVolumes.timemachine


# Avahi
pkg_add -r avahi
cd /usr/local/etc/
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi_daemon.conf
cd /usr/local/etc/avahi/services
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/backup.timemachine.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/service.netatalk.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/service.samba.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/service.ssh.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/web.ZFSguru.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/web.phpvirtualbox.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/web.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/web.subsonic.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/web.transmission.service
fetch https://raw.github.com/lordzurp/Zurpatator2/master/usr_conf/avahi.services/web.webmin.service


# SubVersion
#pkg_add -r subversion

# Mail
pkg_add -r fetchmail procmail

# ftp
pkg_add -r proftpd proftpd-mysql

# Web
#pkg_add -r lighttpd


# Divers
#pkg_add -r krb5 bind96 pdflib

# Port manager
#pkg_add -r managepkg portmaster portupgrade

# securit�
#pkg_add -r openssl openldap-client nss ca_root_nss nss_mdns      

# Utils
pkg_add -r websvn nano iperf gzip bash sudo sudoscript sudosh3 cups-base cups-pdf  geany clean gnupg logrotate  screen smartmontools aircrack-ng

########################
### Install X server ###
########################

# Xorg & xfce
pkg_add -r xorg xorg-drivers liberation-fonts-ttf xfce4

# X utils
pkg_add -r bitstream-vera

# X packages
pkg_add -r chromium xfe xfce4-media thunar-volman leafpad

# Configure X
cd /root/
X -configure
mv xorg.conf.new /etc/X11/xorg.conf

# Localisation
cd /usr/local/etc/hal/fdi/policy/
fetch https://raw.github.com/lordzurp/Zurpatator2/master/misc/x11-input.fdi
echo 'setenv LANG fr_FR.UTF-8' >> /etc/csh.login
echo 'setenv MM_CHARSET UTF-8' >> /etc/csh.login
echo 'setenv LC_ALL fr_FR.UTF-8' >> /etc/csh.login

#################
### Web Panel ###
#################

# Web Panel
pkg_add -r phpvirtualbox phpmyadmin webalizer

# Webmin
cd /usr/local 
fetch http://prdownloads.sourceforge.net/webadmin/webmin-1.550.tar.gz 
gunzip webmin-1.550.tar.gz 
tar -xvf webmin-1.550.tar 
cd webmin-1.550 
./setup.sh


##############
### Reboot ###
##############

echo "reboot necessaire (shutdown -r now) !!"

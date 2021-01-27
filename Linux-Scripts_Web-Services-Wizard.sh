#!/bin/bash

# Tell the script to exit on error
set -e

# Description
echo "This script takes you through the process of installing the base configuration"
echo "necessary for web services. After each component is installed you'll be asked"
echo "whether you'd like to continue with the next stage."

echo ""
echo "ALL OUTPUT WILL BE SAVED TO /var/log/web-services-wizard.log"

function confirmation {
	echo ""
	echo "Begin the installation/continue with the next stage? [y/N]"
	read decision
	
	if [ $decision = "y" ] || [ $decision = "Y" ] ; then
		echo "Continuing install"
		echo ""
	else
		echo "Exiting"
		exit 0
	fi
}

# Confirm user wants to install PHP
echo ""
echo "PHP 7.3 and the required repositories will be installed"
confirmation

# Install official Fedora EPEL repo, Remi repo, yum-utils and PHP
{
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install yum-utils
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php73
yum install php php-cli php-curl php-pecl-mysql php73-php-pecl-mysql php73-build.x86_64 php73-php-cli.x86_64 php73-php-common.x86_64 php73-php-dba.x86_64 php73-php-gd.x86_64 php73-php-mysqlnd.x86_64 php73-php-pdo.x86_64 php73-php-pdo-dblib.x86_64 php73-php-pear.noarch
} >> /var/log/web-services-wizard.log

# Confirm user wants to install Apache
echo ""
echo "Apache 2.4 will be installed"
confirmation

# Install Apache
{
yum install httpd
} >> /var/log/web-services-wizard.log

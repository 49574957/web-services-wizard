#!/bin/bash

function confirmation {
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

# Tell the script to exit on error
set -e

# Description
echo "This script takes you through the process of installing the base configuration"
echo "necessary for web services on CENTOS 7. After each stage you'll be asked whether"
echo "you'd like to continue with the next stage."

# Confirm user wants to install PHP and Apache
echo ""
echo "PHP 7.3, Apache and the required repositories will be installed"
confirmation

# Install official Fedora EPEL repo, Remi repo, yum-utils, PHP and Apache
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install yum-utils
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php73
yum install -y php php-cli php-curl php-pecl-mysql php-xml php73-php-pecl-mysql php73-build.x86_64 php73-php-cli.x86_64 php73-php-common.x86_64 php73-php-dba.x86_64 php73-php-gd.x86_64 php73-php-mysqlnd.x86_64 php73-php-pdo.x86_64 php73-php-pdo-dblib.x86_64 php73-php-pear.noarch

# Confirm user wants the standard Apache file changes and additions to be made
echo ""
echo "The standard Apache configuration changes will be made"
confirmation

# Create additional files
touch /etc/httpd/conf.d/vhost.conf


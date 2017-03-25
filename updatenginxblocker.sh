#!/bin/sh

# Shell Script for Auto Updating the Nginx Bad Bot Blocker
# Copyright - https://github.com/mitchellkrogza
# Project Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker
# Alpine / Arch Linux / Debian / Centos script compatibility by Stuart Cardall

# MAKE SURE you have your whitelist-ips.conf and whitelist-domains.conf files in /etc/nginx/bots.d
# A major change to using include files was introduced in
# https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/commit/c7acdfa8228d2f19a83e5bb14d54355db86fcebf

# PLEASE READ UPDATED CONFIGURATION INSTRUCTIONS BEFORE USING THIS

# Save this file as /usr/sbin/updatenginxblocker
# Make it Executable chmod 700 /usr/sbin/updatenginxblocker

# RUN THE UPDATE
# Here our script runs, pulls the latest update, reloads nginx and emails you a notification

email="me@myemail.com"
conf_dir=/etc/nginx/conf.d
url=https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf

service_cmd() {
	# arch linux does not have a 'service' command
	local svc= svc_list="service systemctl rc-service"

	for svc in $svc_list; do
		svc=$(which $svc 2>/dev/null)
		if [ -n "$svc" ]; then
			echo $svc
			exit 0
		fi
	done
}

# require root
if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# default to service (centos does not have 'which' by default)
service=${service_cmd:-"service"}

# download update & email notification
mkdir -p $conf_dir
wget $url -O $conf_dir/globalblacklist.conf
$service nginx reload | mail -s "Nginx Bad Bot Blocker Updated" $email

exit $?

# Add this as a cron to run daily / weekly as you like
# Here's a sample CRON entry to update every day at 10pm
# 00 22 * * * /usr/sbin/updatenginxblocker

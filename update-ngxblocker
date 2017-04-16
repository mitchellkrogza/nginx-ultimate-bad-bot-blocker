#!/bin/sh

# Shell Script for Auto Updating the Nginx Bad Bot Blocker
# Copyright: https://github.com/mitchellkrogza
# Project Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker
# Update script & Alpine Linux package by Stuart Cardall: https://github.com/itoffshore

# MAKE SURE you have your whitelist-ips.conf,  whitelist-domains.conf and blacklist-user-agents.conf files in /etc/nginx/bots.d
# A major change to using include files was introduced in
# https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/commit/c7acdfa8228d2f19a83e5bb14d54355db86fcebf
# Nginx will fail a reload with [EMERG] without the presence of these files.

# PLEASE READ UPDATED CONFIGURATION INSTRUCTIONS BEFORE USING THIS

# Save this file as /usr/sbin/updatenginxblocker
# Make it Executable chmod 700 /usr/sbin/updatenginxblocker

# RUN THE UPDATE
# Here our script runs, pulls the latest update, reloads nginx and emails you a notification

email="me@myemail.com"
send_email="Y"
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

wget_opts() {
	local opts=

	# Busybox wget gives less verbose output by default
	if [ -n "$(wget --help 2>/dev/null | grep "\-nv")" ]; then
		opts="-nv"
	fi

	opts="$opts -O $conf_dir/globalblacklist.conf"
	echo $opts
}

# require root
if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# default to service (centos does not have 'which' by default)
service=${service_cmd:-"service"}
email_report=$(mktemp)
options=$(wget_opts)

# download update
mkdir -p $conf_dir
wget $url $options 2>&1 | tee $email_report

# re-read configuration
if ! grep "Not Found" $email_report; then
	$service nginx reload | tee -a $email_report
else
	printf "\nDownload failed: not reloading nginx config\n" | tee -a $email_report
fi

# email report
case "$send_email" in
	y*|Y*) cat $email_report | mail -s "Nginx Bad Bot Blocker Updated" $email;;
esac

rm -f $email_report

exit $?

# Add this as a cron to run daily / weekly as you like
# Here's a sample CRON entry to update every day at 10pm
# 00 22 * * * /usr/sbin/updatenginxblocker

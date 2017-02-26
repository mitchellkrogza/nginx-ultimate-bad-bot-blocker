#!/bin/bash
# Bash Script for Auto Updating the Nginx Bad Bot Blocker
# Copyright - https://github.com/mitchellkrogza
# Project Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

# MAKE SURE you have your whitelist-ips.conf and whitelist-domains.conf files in /etc/nginx/bots.d
# A major change to using include files was introduced in
# https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/commit/c7acdfa8228d2f19a83e5bb14d54355db86fcebf

# PLEASE READ UPDATED CONFIGURATION INSTRUCTIONS BEFORE USING THIS

# Save this file as /bin/updatenginxblocker.sh
# Make it Executable chmod +x /bin/updatenginxblocker.sh

# RUN THE UPDATE
# Here our script runs, pulls the latest update, reloads nginx and emails you a notification
# Place your own valid email address where it says "me@myemail.com"
 
cd /etc/nginx/conf.d
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf -O globalblacklist.conf
sudo service nginx reload | mail -s "Nginx Bad Bot Blocker Updated" me@myemail.com
exit 0

# Add this as a cron to run daily / weekly as you like
# Here's a sample CRON entry to update every day at 10pm
# 00 22 * * * /bin/updatenginxblocker.sh

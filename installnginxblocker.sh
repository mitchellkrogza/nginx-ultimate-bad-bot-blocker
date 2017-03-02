#!/bin/bash
# Bash Script for Installing the Nginx Bad Bot Blocker
# Copyright - https://github.com/mitchellkrogza
# Project Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

# PLEASE READ CONFIGURATION INSTRUCTIONS BEFORE USING THIS - THIS IS ONLY A PARTIAL INSTALLER
# FOR COPYING THE FILES CORRECTLY TO NGINX INTO THE CORRECT FOLDERS
# https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/CONFIGURATION.md

# Use this script only once and thereafter use the Auto Update Bash Script updatenginxblocker.sh

# THIS INSTALL SCRIPT **ONLY** COPIES THE NECESSARY FILES FOR NGINX DIRECT FROM THE REPO
### The installer script does not carry out STEP 6 of the configuration instructions for you. 
### You must manually edit any vhost files with the includes in STEP 6 or it will not actually be protecting any sites.
### READ: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/CONFIGURATION.md

# Save this file as /bin/installnginxblocker.sh
# Make it Executable chmod +x /bin/installnginxblocker.sh
# Run it from the command line using sudo /bin/installnginxblocker.sh

# LETS INSTALL NOW
 
cd /etc/nginx/conf.d
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf -O globalblacklist.conf
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/botblocker-nginx-settings.conf -O botblocker-nginx-settings.conf
sudo mkdir /etc/nginx/bots.d
cd /etc/nginx/bots.d
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blockbots.conf -O blockbots.conf
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/ddos.conf -O ddos.conf
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-ips.conf -O whitelist-ips.conf
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-domains.conf -O whitelist-domains.conf
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blacklist-user-agents.conf -O blacklist-user-agents.conf
exit 0

# PLEASE READ CONFIGURATION INSTRUCTIONS
# https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/CONFIGURATION.md
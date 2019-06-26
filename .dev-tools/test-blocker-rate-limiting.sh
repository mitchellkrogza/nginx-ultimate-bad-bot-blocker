#!/bin/bash
# Curl Testing Script for Nginx Ultimate Bad Bot Blocker
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

##############################################################################                                                                
#       _  __     _                                                          #
#      / |/ /__ _(_)__ __ __                                                 #
#     /    / _ `/ / _ \\ \ /                                                 #
#    /_/|_/\_, /_/_//_/_\_\                                                  #
#       __/___/      __   ___       __     ___  __         __                #
#      / _ )___ ____/ /  / _ )___  / /_   / _ )/ /__  ____/ /_____ ____      #
#     / _  / _ `/ _  /  / _  / _ \/ __/  / _  / / _ \/ __/  '_/ -_) __/      #
#    /____/\_,_/\_,_/  /____/\___/\__/  /____/_/\___/\__/_/\_\\__/_/         #
#                                                                            #
##############################################################################                                                                

# ************************
# Set Terminal Font Colors
# ************************

bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
defaultcolor=$(tput setaf default)

# ******************
# TEST RATE LIMITING
# ******************

printf "\n"
echo "${bold}${green}---------------------------"
echo "${bold}${green}Starting Rate Limiting Test"
echo "${bold}${green}---------------------------"
printf "\n\n"

# ***************************
# Make GoogleBot Rate Limited
# ***************************

echo "${bold}${yellow}-----------------------------"
echo "${bold}${yellow}Making GoogleBot ${yellow}RATE LIMITED"
echo "${bold}${yellow}-----------------------------"
printf "\n\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/rate-limiting-user-agents.conf /etc/nginx/bots.d/blacklist-user-agents.conf

echo "${bold}${green}---------------"
echo "${bold}${green}Reloading Nginx"
echo "${bold}${green}---------------"
printf "\n\n"
sudo nginx -t && sudo nginx -s reload

echo "${bold}${yellow}-----------------------------------------------------------------------"
echo "${bold}${yellow}Sleeping for 10 seconds to allow Nginx to Properly Reload inside Travis"
echo "${bold}${yellow}-----------------------------------------------------------------------"
printf "\n\n"
sleep 10s

ratelimittestfile=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/ratelimittest.txt
truncate -s 0 ${ratelimittestfile}
curl -A "GoogleBot" http://localhost:9000 2>&1 > ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:9000 2>&1 >> ${ratelimittestfile} 

if grep -i 'Unavailable' < ${ratelimittestfile}; then
   echo "${bold}${green}PASSED - ${red}GoogleBot was ${bold}${red}RATE LIMITED"
   else
   echo "${bold}${red}FAILED - ${red}GoogleBot was ${bold}${red}NOT RATE LIMITED"
   fi

# *************************************************************
# Copy all .conf files used in Testing to a folder for checking
# *************************************************************

printf "\n"
echo "${bold}${green}------------------------------------------------------------"
echo "${bold}${green}Make Backup all conf files and folders used during this test"
echo "${bold}${green}------------------------------------------------------------"
printf "\n"
sudo cp /etc/nginx/bots.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_testing_changes_ratelimiting/bots.d/
sudo cp /etc/nginx/conf.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_testing_changes_ratelimiting/conf.d/
sudo cp /etc/nginx/sites-available/default.vhost ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_testing_changes_ratelimiting/default.vhost
sudo cp /etc/nginx/nginx.conf ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_testing_changes_ratelimiting/nginx.conf



printf "\n"
echo "${bold}${green}---------------------------"
echo "${bold}${green}Rate Limiting Test Complete"
echo "${bold}${green}---------------------------"
printf "\n\n"

# **********************
# Exit With Error Number
# **********************

exit ${?}



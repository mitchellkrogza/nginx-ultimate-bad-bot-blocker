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

echo "${bold}${green}--------------------------"
echo "${bold}${green}Whitelisting Test Starting"
echo "${bold}${green}--------------------------"
printf "\n\n"

echo "${bold}${green}------------------------------------------------"
echo "${bold}${green}Activating Users User-Agents Whitelist/Blacklist"
echo "${bold}${green}------------------------------------------------"
printf "\n\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/blacklist-user-agents.conf /etc/nginx/bots.d/blacklist-user-agents.conf
echo "${bold}${green}----------------------------------------------"
echo "${bold}${green}Activating Users Referrers Whitelist/Blacklist"
echo "${bold}${green}----------------------------------------------"
printf "\n\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/custom-bad-referrers.conf /etc/nginx/bots.d/custom-bad-referrers.conf
echo "${bold}${green}---------------"
echo "${bold}${green}Reloading Nginx"
echo "${bold}${green}---------------"
printf "\n\n"
sudo nginx -t && sudo nginx -s reload


echo "${bold}${yellow}-----------------------------------------------------------------------"
echo "${bold}${yellow}Sleeping for 30 seconds to allow Nginx to Properly Reload inside Travis"
echo "${bold}${yellow}-----------------------------------------------------------------------"
printf "\n\n"
sleep 30s

# *******************************************************
# Function Curl Test 1 - Test User Whitelist for "Nutch"
# *******************************************************

run_curltest1 () {
if curl -v -A "Nutch" http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - WHITELISTING OF BAD BOT Nutch ALLOWED"
else
   echo "${bold}${red}FAILED - WHITELISTING of BAD BOT Nutch FAILED"
   #exit 1
   curl -v -A "Nutch" http://localhost:9000 2>&1
fi
}
run_curltest1

# **************************************************************
# Function Curl Test 2 - Check for Whitelisted Referrer "zx6.ru"
# **************************************************************

run_curltest2 () {
if curl http://localhost:9000 -e http://zx6.ru 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - WHITELISTING OF REFERRER zx6.ru ALLOWED"
else
   echo "${bold}${red}FAILED - WHITELISTING OF REFERRER zx6.ru FAILED"
   #exit 1
   curl http://localhost:9000 -e http://zx6.ru 2>&1
fi
}
run_curltest2


printf "\n"
echo "${bold}${green}--------------------------"
echo "${bold}${green}Whitelisting Test Complete"
echo "${bold}${green}--------------------------"
printf "\n\n"

latestbuild=V4.${YEAR}.${MONTH}.${TRAVIS_BUILD_NUMBER}
printf "\n"
echo "${bold}${green}All Nginx Tests Completed"
echo "${bold}${green}All Bot and Referrer Testing Completed"
echo "${bold}${green}All Function Testing Completed"
echo "${bold}${magenta}Releasing ${latestbuild}"

# **********************
# Exit With Error Number
# **********************

exit ${?}



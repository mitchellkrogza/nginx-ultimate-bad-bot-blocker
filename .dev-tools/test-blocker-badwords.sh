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

echo "${bold}${green}--------------------------------"
echo "${bold}${green}Bad Referrer Words Test Starting"
echo "${bold}${green}--------------------------------"
printf "\n\n"

echo "${bold}${green}----------------------------------------"
echo "${bold}${green}Activating Users bad-referrer-words.conf"
echo "${bold}${green}----------------------------------------"
printf "\n\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/bad-referrer-words.conf /etc/nginx/bots.d/bad-referrer-words.conf
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
if curl -I http://localhost:9000 -e "thisisabadword" 2>&1 | grep -i '(52)'; then
   echo "${bold}${green}PASSED - User bad-referrer-words.conf working"
else
   echo "${bold}${red}FAILED - User bad-referrer-words.conf NOT working"
   #exit 1
fi
}
run_curltest1

# **************************************************************
# Function Curl Test 2 - Check for Whitelisted Referrer "zx6.ru"
# **************************************************************

run_curltest2 () {
if curl -I http://localhost:9000 -e "thisisanotherbadword" 2>&1 | grep -i '(52)'; then
   echo "${bold}${green}PASSED - User bad-referrer-words.conf working"
else
   echo "${bold}${red}FAILED - User bad-referrer-words.conf NOT working"
   #exit 1
fi
}
run_curltest2


echo "${bold}${green}--------------------------------"
echo "${bold}${green}Bad Referrer Words Test Complete"
echo "${bold}${green}--------------------------------"
printf "\n\n"

# **********************
# Exit With Error Number
# **********************

exit ${?}



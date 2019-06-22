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

echo "Whitelist Tests Starting"

echo "Activating User Whitelist/Blacklist"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/blacklist-user-agents.conf /etc/nginx/bots.d/blacklist-user-agents.conf
echo "Reloading Nginx"
sudo nginx -t && sudo nginx -s reload


# *******************************************************
# Function Curl Test 16 - Test User Whitelist for "Nutch"
# *******************************************************

run_curltest1 () {
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING USER WHITELIST" "#########################"
if curl -v -A "Nutch" http://localhost:9000/index.php 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)WHITELISTING OF BAD BOT ALLOWED - TEST PASSED"
else
   echo "$(tput setaf 1)WHITELISTING FAILED - TEST FAILED"
   #exit 1
   curl -v -A "Nutch" http://localhost:9000/index.php 2>&1
fi
}
run_curltest1

sudo cat /etc/nginx/bots.d/blacklist-user-agents.conf

echo "Whitelist Tests Completed"

# **********************
# Exit With Error Number
# **********************

exit ${?}



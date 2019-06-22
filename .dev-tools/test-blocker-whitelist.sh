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

echo "Activating Users User-Agents Whitelist/Blacklist"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/blacklist-user-agents.conf /etc/nginx/bots.d/blacklist-user-agents.conf
echo "Activating Users Referrers Whitelist/Blacklist"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/custom-bad-referrers.conf /etc/nginx/bots.d/custom-bad-referrers.conf
echo "Reloading Nginx"
sudo nginx -t && sudo nginx -s reload


echo "Sleeping for 30 seconds to allow Nginx Properly Reload inside Travis"
sleep 30s

# *******************************************************
# Function Curl Test 1 - Test User Whitelist for "Nutch"
# *******************************************************

run_curltest1 () {
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING USER WHITELIST" "#########################"
if curl -v -A "Nutch" http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)WHITELISTING OF BAD BOT ALLOWED - TEST PASSED"
else
   echo "$(tput setaf 1)WHITELISTING FAILED - TEST FAILED"
   #exit 1
   curl -v -A "Nutch" http://localhost:9000 2>&1
fi
}
run_curltest1

# **************************************************************
# Function Curl Test 2 - Check for Whitelisted Referrer "zx6.ru"
# **************************************************************

run_curltest2 () {
printf '\n%s\n%s\n%s\n\n' "##############################" "TESTING BAD REFERRER IS DENIED" "##############################"
if curl -I http://localhost:9000/index.html -e http://zx6.ru 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)WHITELISTING OF BAD BOT ALLOWED - TEST PASSED"
else
   echo "$(tput setaf 1)WHITELISTING FAILED - TEST FAILED"
   #exit 1
   curl -v -A "Nutch" http://localhost:9000 2>&1
fi
}
run_curltest2


echo "Whitelist Tests Completed"

# **********************
# Exit With Error Number
# **********************

exit ${?}



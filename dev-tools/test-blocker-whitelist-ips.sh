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

# ------------------------------------------------------------------------------
# MIT License
# ------------------------------------------------------------------------------
# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza
# ------------------------------------------------------------------------------
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# ------------------------------------------------------------------------------
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# ------------------------------------------------------------------------------
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------

# ------------------------
# Set Terminal Font Colors
# ------------------------

bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
defaultcolor=$(tput setaf default)
thisip=$(dig +short myip.opendns.com @resolver1.opendns.com)

# ---------
# FUNCTIONS
# ---------

reloadNginX () {
echo "${bold}${green}---------------"
echo "${bold}${green}Reloading Nginx"
echo "${bold}${green}---------------"
sudo nginx -t && sudo nginx -s reload
}

waitforReload () {
echo "${bold}${yellow}-----------------------------------------------------------------------"
echo "${bold}${yellow}Sleeping for 10 seconds to allow Nginx to Properly Reload inside Travis"
echo "${bold}${yellow}-----------------------------------------------------------------------"
printf "\n"
sleep 10s
}

run_curltest1 () {
if curl http://localhost:9000 2>&1 | grep -i '(52)'; then
   echo "${bold}${green}PASSED - ${bold}${red}blacklist own ip is WORKING"
else
   echo "${bold}${red}FAILED - blacklist own ip is NOT working"
   exit 1
fi
}

run_curltest2 () {
if curl http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - whitelist own ip is WORKING"
else
   echo "${bold}${red}FAILED - whitelist own ip is NOT working"
   curl http://localhost:9000
   exit 1
fi
}

backupConfFiles () {
printf "\n"
echo "${bold}${green}------------------------------------------------------------"
echo "${bold}${green}Make Backup all conf files and folders used during this test"
echo "${bold}${green}------------------------------------------------------------"
printf "\n"
sudo cp /etc/nginx/bots.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/test1_conf_files_ip_whitelist/bots.d/
sudo cp /etc/nginx/conf.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/test1_conf_files_ip_whitelist/conf.d/
sudo cp /etc/nginx/sites-available/default.vhost ${TRAVIS_BUILD_DIR}/.dev-tools/test1_conf_files_ip_whitelist/default.vhost
sudo cp /etc/nginx/nginx.conf ${TRAVIS_BUILD_DIR}/.dev-tools/test1_conf_files_ip_whitelist/nginx.conf
}

blacklistOwnIP () {
sudo truncate -s 0 ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/blacklist-ips.conf
printf '%s\t%s\n' "${thisip}" "1;" > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/blacklist-ips.conf
printf '%s\t%s\n' "127.0.0.1" "1;" >> ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/blacklist-ips.conf
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/blacklist-ips.conf /etc/nginx/bots.d/blacklist-ips.conf
sudo truncate -s 0 ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/whitelist-ips.conf
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/whitelist-ips.conf /etc/nginx/bots.d/whitelist-ips.conf
}

whitelistOwnIP () {
sudo truncate -s 0 ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/whitelist-ips.conf
printf '%s\t%s\n' "${thisip}" "0;" > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/whitelist-ips.conf
printf '%s\t%s\n' "127.0.0.1" "0;" >> ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/whitelist-ips.conf
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/whitelist-ips.conf /etc/nginx/bots.d/whitelist-ips.conf
# TEST ANY CHANGES TO botblocker-nginx-settings.conf
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/botblocker-nginx-settings.conf /etc/nginx/conf.d/botblocker-nginx-settings.conf
}

# -----------
# Start Tests
# -----------

echo "${bold}${green}--------------------------"
echo "${bold}${green}Whitelist IP Test Starting"
echo "${bold}${green}--------------------------"
printf "\n"

echo "${bold}${green}-------------------------"
echo "${bold}${green}Blacklisting own IP First"
echo "${bold}${green}-------------------------"
printf "\n"

blacklistOwnIP
reloadNginX
waitforReload
run_curltest1

echo "${bold}${green}--------------------"
echo "${bold}${green}Now Whitelist own IP"
echo "${bold}${green}--------------------"
printf "\n"

whitelistOwnIP
reloadNginX
waitforReload
run_curltest2

echo "${bold}${green}-----------------------------"
echo "${bold}${green}Whitelisting IP Test Complete"
echo "${bold}${green}-----------------------------"
printf "\n"

# *************************************************************
# Copy all .conf files used in Testing to a folder for checking
# *************************************************************

backupConfFiles

# **********************
# Exit With Error Number
# **********************

exit ${?}

# ------------------------------------------------------------------------------
# MIT License
# ------------------------------------------------------------------------------
# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza
# ------------------------------------------------------------------------------
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# ------------------------------------------------------------------------------
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# ------------------------------------------------------------------------------
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------

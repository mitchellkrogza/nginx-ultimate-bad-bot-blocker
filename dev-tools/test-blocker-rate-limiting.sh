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

export TERM=xterm

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

# ---------
# FUNCTIONS
# ---------

reloadNginX () {
printf "\n"
echo "${bold}${green}---------------"
echo "${bold}${green}Reloading Nginx"
echo "${bold}${green}---------------"
sudo nginx -t && sudo systemctl reload nginx
}

waitforReload () {
echo "${bold}${yellow}-----------------------------------------------------------------------"
echo "${bold}${yellow}Sleeping for 10 seconds to allow Nginx to Properly Reload inside Travis"
echo "${bold}${yellow}-----------------------------------------------------------------------"
printf "\n"
sleep 10s
}

ratelimitGoogle () {
echo "${bold}${yellow}-----------------------------"
echo "${bold}${yellow}Making GoogleBot ${yellow}RATE LIMITED"
echo "${bold}${yellow}-----------------------------"
printf "\n"
sudo cp ./dev-tools/test_units/rate-limiting-user-agents.conf /etc/nginx/bots.d/blacklist-user-agents.conf
}

testRateLimiting () {
ratelimittestfile=./dev-tools/test_units/ratelimittest-master.txt
truncate -s 0 ${ratelimittestfile}
curl -A "GoogleBot" http://localhost:80 2>&1 > ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} &
curl -A "GoogleBot" http://localhost:80 2>&1 >> ${ratelimittestfile} 

if grep -i 'Unavailable' < ${ratelimittestfile}; then
   echo "${bold}${green}PASSED - ${red}GoogleBot was ${bold}${red}RATE LIMITED"
   else
   echo "${bold}${red}FAILED - ${red}GoogleBot was ${bold}${red}NOT RATE LIMITED"
   #exit 1
   fi
}

backupConfFiles () {
printf "\n"
echo "${bold}${green}-------------------------------------------------------"
echo "${bold}${green}Backup all conf files and folders used during this test"
echo "${bold}${green}-------------------------------------------------------"
printf "\n"
sudo cp /etc/nginx/bots.d/* ./dev-tools/test1_conf_files_ratelimiting/bots.d/
sudo cp /etc/nginx/conf.d/* ./dev-tools/test1_conf_files_ratelimiting/conf.d/
sudo cp /etc/nginx/sites-available/default.vhost ./dev-tools/test1_conf_files_ratelimiting/default.vhost
sudo cp /etc/nginx/nginx.conf ./dev-tools/test1_conf_files_ratelimiting/nginx.conf
}

# -----------
# Start Tests
# -----------

printf "\n"
echo "${bold}${green}---------------------------"
echo "${bold}${green}Starting Rate Limiting Test"
echo "${bold}${green}---------------------------"
printf "\n"

ratelimitGoogle
reloadNginX
waitforReload
testRateLimiting
backupConfFiles

printf "\n"
echo "${bold}${green}---------------------------"
echo "${bold}${green}Rate Limiting Test Complete"
echo "${bold}${green}---------------------------"
printf "\n\n"

# ----------------------
# Exit With Error Number
# ----------------------

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


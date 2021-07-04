#!/bin/bash
# Travis CI Generating and Building for the Nginx Ultimate Bad Bot Blocker
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

set -e
set -o pipefail
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

startNginX () {
printf "\n"
echo "${bold}${green}---------------"
echo "${bold}${green}Starting Nginx"
echo "${bold}${green}---------------"
sudo systemctl enable nginx.service
#sudo systemctl status nginx.service
sudo nginx -t
sudo systemctl start nginx.service
#sudo systemctl start nginx
#sudo systemctl restart nginx
}

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

backupNginxConf () {
printf "\n"
echo "${bold}${yellow}---------------------------"
echo "${bold}${yellow}Making backup of nginx.conf"
echo "${bold}${yellow}---------------------------"
sudo cp /etc/nginx/nginx.conf ./dev-tools/test1_conf_backup_nginxconf/nginx.conf
}

prepareVhost () {
printf "\n"
echo "${bold}${yellow}-------------------------------------------"
echo "${bold}${yellow}Delete any default files installed by Nginx"
echo "${bold}${yellow}-------------------------------------------"
sudo rm /etc/nginx/sites-available/*
sudo rm /etc/nginx/sites-enabled/*
sudo rm /var/www/html/*
printf "\n"
echo "${bold}${yellow}---------------------"
echo "${bold}${yellow}Setup Vhost for Nginx"
echo "${bold}${yellow}---------------------"
sudo cp ./dev-tools/default.vhost /etc/nginx/sites-available/default.vhost
sudo ln -s /etc/nginx/sites-available/default.vhost /etc/nginx/sites-enabled/default.vhost
sudo cp ./dev-tools/index.html /var/www/html/index.html
}

makeScriptsExecutable () {
sudo chmod +x /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/setup-ngxblocker
sudo chmod +x /usr/sbin/update-ngxblocker
}

getinstallngxblocker () {
printf "\n"
echo "${bold}${magenta}--------------------------------------"
echo "${bold}${magenta}Fetch install-ngxblocker from the repo"
echo "${bold}${magenta}--------------------------------------"
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/install-ngxblocker
}

runinstallngxblocker () {
echo "${bold}${magenta}--------------------------"
echo "${bold}${magenta}Execute install-ngxblocker"
echo "${bold}${magenta}--------------------------"
sudo bash /usr/sbin/install-ngxblocker -s /usr/sbin/ -x
}

runsetupngxblocker1 () {
printf "\n"
echo "${bold}${magenta}------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker"
echo "${bold}${magenta}------------------------"
sudo bash /usr/sbin/setup-ngxblocker -i /usr/sbin/install-ngxblocker -x
}

runsetupngxblocker2 () {
printf "\n"
echo "${bold}${magenta}------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker"
echo "${bold}${magenta}------------------------"
sudo bash /usr/sbin/setup-ngxblocker -x
}

loadNginxConf () {
sudo nginx -c /etc/nginx/nginx.conf
}

forceUpdateTest1 () {
printf "\n"
echo "${bold}${yellow}----------------------------------------------------"
echo "${bold}${yellow}Copy older globalblacklist.conf file to force update"
echo "${bold}${yellow}----------------------------------------------------"
sudo cp ./dev-tools/globalblacklist-dummy.conf /etc/nginx/conf.d/globalblacklist.conf
}

forceUpdateTest2 () {
echo "${bold}${yellow}--------------------------------------"
echo "${bold}${yellow}Delete Files to test update-ngxblocker"
echo "${bold}${yellow}--------------------------------------"
sudo rm /etc/nginx/conf.d/*.conf
sudo rm /etc/nginx/bots.d/*.conf
ls -la /etc/nginx/conf.d/
ls -la /etc/nginx/bots.d/
}

forceUpdateTest3 () {
printf "\n"
echo "${bold}${yellow}----------------------------------------------------"
echo "${bold}${yellow}Copy older globalblacklist.conf file to force update"
echo "${bold}${yellow}----------------------------------------------------"
sudo cp ./dev-tools/globalblacklist-dummy.conf /etc/nginx/conf.d/globalblacklist.conf
}

runupdatengxblocker () {
printf "\n"
echo "${bold}${magenta}-------------------------"
echo "${bold}${magenta}Execute update-ngxblocker"
echo "${bold}${magenta}-------------------------"
sudo bash /usr/sbin/update-ngxblocker -n
}

activateLatestBlacklist () {
echo "${bold}${yellow}------------------------------------------------------------"
echo "${bold}${yellow}Make sure we test with latest generated globalblacklist.conf"
echo "${bold}${yellow}------------------------------------------------------------"
sudo cp ./conf.d/globalblacklist.conf /etc/nginx/conf.d/globalblacklist.conf
}

backupConfFiles () {
printf "\n"
echo "${bold}${green}-------------------------------------------------------"
echo "${bold}${green}Backup all conf files and folders used during this test"
echo "${bold}${green}-------------------------------------------------------"
sudo cp /etc/nginx/bots.d/* ./dev-tools/test1_conf_files/bots.d/
sudo cp /etc/nginx/conf.d/* ./dev-tools/test1_conf_files/conf.d/
sudo cp /etc/nginx/sites-available/default.vhost ./dev-tools/test1_conf_files/default.vhost
sudo cp /etc/nginx/nginx.conf ./dev-tools/test1_conf_files/nginx.conf
}

copyNginxConf () {
printf "\n"
echo "${bold}${magenta}------------------------------"
echo "${bold}${magenta}Copy nginx.conf to /etc/nginx/"
echo "${bold}${magenta}------------------------------"
sudo cp ./dev-tools/test_units/nginx.conf-newformat /etc/nginx/nginx.conf
}

getnginxversion () {
sudo nginx -v &> ./dev-tools/nginxv1.txt
}

# ------------------
# Start Installation
# ------------------

printf "\n"
echo "${bold}${green}------------------"
echo "${bold}${green}Start Nginx Test 1"
echo "${bold}${green}------------------"

backupNginxConf
copyNginxConf
prepareVhost
getinstallngxblocker
runinstallngxblocker
makeScriptsExecutable
runsetupngxblocker1
loadNginxConf
forceUpdateTest1
runupdatengxblocker
startNginX
reloadNginX
waitforReload
forceUpdateTest2
runupdatengxblocker
forceUpdateTest3
runsetupngxblocker2
reloadNginX
waitforReload
activateLatestBlacklist
reloadNginX
backupConfFiles
getnginxversion

# ----------------------
# Exit With Error Number
# ----------------------

#exit ${?}

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

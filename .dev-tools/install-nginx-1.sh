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

# MIT License

# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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

# ***************************************************************
# Start Getting Nginx Ready for Testing the Nginx Bad Bot Blocker
# ***************************************************************

printf "\n"
echo "${bold}${magenta}------------------"
echo "${bold}${magenta}Start Nginx Test 1"
echo "${bold}${magenta}------------------"
printf "\n"

# ******************************************************
# Make a backup of the clean and default nginx.conf file
# Needed to run Nginx test 3
# ******************************************************

printf "\n"
echo "${bold}${cyan}---------------------------"
echo "${bold}${cyan}Making backup of nginx.conf"
echo "${bold}${cyan}---------------------------"
printf "\n"
sudo cp /etc/nginx/nginx.conf ${TRAVIS_BUILD_DIR}/.dev-tools/_nginx_conf_backup/nginx.conf

# *************************************************
# Delete default site created by Nginx Installation
# *************************************************

printf "\n"
echo "${bold}${cyan}-------------------------------------------"
echo "${bold}${cyan}Delete any default files installed by Nginx"
echo "${bold}${cyan}-------------------------------------------"
printf "\n"
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
sudo rm /var/www/html/*

# ********************************************************
# Copy our default.vhost file into Nginx /sites-available/
# ********************************************************

printf "\n"
echo "${bold}${cyan}---------------------"
echo "${bold}${cyan}Setup Vhost for Nginx"
echo "${bold}${cyan}---------------------"
printf "\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/default.vhost /etc/nginx/sites-available/default.vhost

# **********************************************
# Link the vhost file into Nginx /sites-enabled/
# **********************************************

sudo ln -s /etc/nginx/sites-available/default.vhost /etc/nginx/sites-enabled/default.vhost

# ***********************************************************
# Copy our index.php file into the default site's root folder
# ***********************************************************

sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/index.html /var/www/html/index.html

# ***********************************************
# Fetch our install-ngxblocker file from the repo
# ***********************************************

printf "\n"
echo "${bold}${magenta}--------------------------------------"
echo "${bold}${magenta}Fetch install-ngxblocker from the repo"
echo "${bold}${magenta}--------------------------------------"
printf "\n"

sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/install-ngxblocker

# **********************
# Run Install-NgxBlocker
# **********************

printf "\n"
echo "${bold}${magenta}--------------------------"
echo "${bold}${magenta}Execute install-ngxblocker"
echo "${bold}${magenta}--------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./install-ngxblocker -s /usr/sbin/ -x

# **************************************************
# Set our install and setup scripts to be executable
# **************************************************

sudo chmod +x /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/setup-ngxblocker
sudo chmod +x /usr/sbin/update-ngxblocker

# ********************
# Run setup-ngxblocker
# ********************

printf "\n"
echo "${bold}${magenta}------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker"
echo "${bold}${magenta}------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./setup-ngxblocker -i /usr/sbin/install-ngxblocker -x

# ************************
# Load our Nginx.conf file
# ************************

sudo nginx -c /etc/nginx/nginx.conf

# ****************************************************************************************
# Copy a dummy version of globalblacklist.conf with an older version number to test update
# ****************************************************************************************

printf "\n"
echo "${bold}${magenta}----------------------------------------------------"
echo "${bold}${magenta}Copy older globalblacklist.conf file to force update"
echo "${bold}${magenta}----------------------------------------------------"
printf "\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/globalblacklist-dummy.conf /etc/nginx/conf.d/globalblacklist.conf

# ****************************************************************************************
# Run update-ngxblocker test which downloads latest globalblacklist.conf and reloads Nginx
# ****************************************************************************************

printf "\n"
echo "${bold}${magenta}-------------------------"
echo "${bold}${magenta}Execute update-ngxblocker"
echo "${bold}${magenta}-------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./update-ngxblocker -n

# *********************
# Force reload of Nginx
# *********************

printf "\n"
echo "${bold}${green}------------"
echo "${bold}${green}Reload Nginx"
echo "${bold}${green}------------"
printf "\n"
sudo nginx -t && sudo nginx -s reload

# *******************************************************************************************
# Test that update-ngxblocker can install all missing required files by deleting some of them
# *******************************************************************************************

printf "\n"
echo "${bold}${yellow}--------------------------------------"
echo "${bold}${yellow}Delete Files to test update-ngxblocker"
echo "${bold}${yellow}--------------------------------------"
printf "\n"
sudo rm /etc/nginx/conf.d/*.conf
sudo rm /etc/nginx/bots.d/*.conf
ls -la /etc/nginx/conf.d/
ls -la /etc/nginx/bots.d/

# *********************************************************************************************************
# Run update-ngxblocker to test for missing files and download latest globalblacklist.conf and reload Nginx
# *********************************************************************************************************

printf "\n"
echo "${bold}${magenta}-------------------------"
echo "${bold}${magenta}Execute update-ngxblocker"
echo "${bold}${magenta}-------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./update-ngxblocker -n

# ****************************************************************************************
# Copy a dummy version of globalblacklist.conf with an older version number to test update
# ****************************************************************************************

printf "\n"
echo "${bold}${magenta}----------------------------------------------------"
echo "${bold}${magenta}Copy older globalblacklist.conf file to force update"
echo "${bold}${magenta}----------------------------------------------------"
printf "\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/globalblacklist-dummy.conf /etc/nginx/conf.d/globalblacklist.conf

# *********************************************************************************************************
# Run update-ngxblocker to test for missing files and download latest globalblacklist.conf and reload Nginx
# *********************************************************************************************************

printf "\n"
echo "${bold}${magenta}-------------------------"
echo "${bold}${magenta}Execute update-ngxblocker"
echo "${bold}${magenta}-------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./update-ngxblocker -n

# **************************
# Run setup-ngxblocker again
# **************************

printf "\n"
echo "${bold}${magenta}------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker"
echo "${bold}${magenta}------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./setup-ngxblocker -x

# *********************
# Force reload of Nginx
# *********************

printf "\n"
echo "${bold}${green}------------"
echo "${bold}${green}Reload Nginx"
echo "${bold}${green}------------"
printf "\n"
sudo nginx -t && sudo nginx -s reload

# *******************************************************
# Make sure we test latest generated globalblacklist.conf
# *******************************************************

printf "\n"
echo "${bold}${magenta}------------------------------------------------------------"
echo "${bold}${magenta}Make sure we test with latest generated globalblacklist.conf"
echo "${bold}${magenta}------------------------------------------------------------"
printf "\n"
sudo cp ${TRAVIS_BUILD_DIR}/conf.d/globalblacklist.conf /etc/nginx/conf.d/globalblacklist.conf

# *********************
# Force reload of Nginx
# *********************

printf "\n"
echo "${bold}${green}------------"
echo "${bold}${green}Reload Nginx"
echo "${bold}${green}------------"
printf "\n"
sudo nginx -t && sudo nginx -s reload

# ************************************************************
# Copy all .conf files used in Test 1 to a folder for checking
# ************************************************************

printf "\n"
echo "${bold}${green}------------------------------------------------------------"
echo "${bold}${green}Make Backup all conf files and folders used during this test"
echo "${bold}${green}------------------------------------------------------------"
printf "\n"
sudo cp /etc/nginx/bots.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_test1/bots.d/
sudo cp /etc/nginx/conf.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_test1/conf.d/
sudo cp /etc/nginx/sites-available/default.vhost ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_test1/default.vhost
sudo cp /etc/nginx/nginx.conf ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_test1/nginx.conf

# **********************
# Exit With Error Number
# **********************

exit ${?}


# MIT License

# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
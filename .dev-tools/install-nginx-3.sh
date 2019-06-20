#!/bin/bash
# Travis CI Generating and Building for the Nginx Ultimate Bad Bot Blocker (using non standard folder locations)
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

# ***************************************************************
# Start Getting Nginx Ready for Testing the Nginx Bad Bot Blocker
# ***************************************************************

# **************************************
# Make Sure We Cleanup From Nginx Test 2
# **************************************

printf '\n%s\n%s\n%s\n\n' "###################################" "       STARTING NGINX TEST 3" "###################################"
printf '\n%s\n%s\n%s\n\n' "###################################" "Cleaning up Files from Nginx Test 2" "###################################"
sudo rm /etc/nginx/sites-available/default.vhost
sudo rm /etc/nginx/sites-enabled/default.vhost
sudo rm /var/www/html/*
sudo rm /usr/local/nginx/conf.d/*.conf
sudo rm /usr/local/nginx/bots.d/*.conf
printf '\n%s\n%s\n%s\n\n' "########################################" "Cleaning up Files from Nginx Test 2 DONE" "########################################"

# *******************************************************
# Restore backup of the clean and default nginx.conf file
# ******************************************************

printf '\n%s\n%s\n%s\n\n' "#################################" "Restoring Default nginx.conf file" "#################################"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/_nginx_conf_backup/nginx.conf /etc/nginx/nginx.conf

# *************************************
# List Directories to Confirm Deletions
# *************************************

printf '\n%s\n%s\n%s\n\n' "######################################################" "Confirming /usr/local/nginx/conf.d/ directory is EMPTY" "######################################################"
ls -la /usr/local/nginx/conf.d/
printf '\n%s\n%s\n%s\n\n' "######################################################" "Confirming /usr/local/nginx/bots.d/ directory is EMPTY" "######################################################"
ls -la /usr/local/nginx/bots.d/
printf '\n%s\n%s\n%s\n\n' "#########################################################" "Confirming /etc/nginx/sites-available/ directory is EMPTY" "#########################################################"
ls -la /etc/nginx/sites-available/
printf '\n%s\n%s\n%s\n\n' "#######################################################" "Confirming /etc/nginx/sites-enabled/ directory is EMPTY" "#######################################################"
ls -la /etc/nginx/sites-enabled/
printf '\n%s\n%s\n%s\n\n' "############################################" "Confirming /var/www/html/ directory is EMPTY" "############################################"
ls -la /var/www/html/
printf '\n%s\n\n' "                                      "

# ********************************************************
# Copy our default.vhost file into Nginx /sites-available/
# ********************************************************

printf '\n%s\n%s\n%s\n\n' "################################" "Get Nginx Setup for Nginx Test 3" "################################"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/default.vhost /etc/nginx/sites-available/default.vhost

# **********************************************
# Link the vhost file into Nginx /sites-enabled/
# **********************************************

sudo ln -s /etc/nginx/sites-available/default.vhost /etc/nginx/sites-enabled/default.vhost

# ***********************************************************
# Copy our index.php file into the default site's root folder
# ***********************************************************

sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/index.php /var/www/html/index.php
printf '\n%s\n%s\n%s\n\n' "#####################################" "Finished Nginx Setup for Nginx Test 3" "#####################################"

# ***********************************************
# Fetch our install-ngxblocker file from the repo
# ***********************************************

printf '\n%s\n%s\n%s\n\n' "######################################" "Fetch install-ngxblocker from the repo" "######################################"
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/install-ngxblocker

# **********************
# Run Install-NgxBlocker
# **********************

printf '\n%s\n%s\n%s\n\n' "######################" "Run install-ngxblocker" "######################"
cd /usr/sbin
sudo bash ./install-ngxblocker -x -c /etc/nginx/myconf.d -b /etc/nginx/mybots.d

# **************************************************
# Set our install and setup scripts to be executable
# **************************************************

printf '\n%s\n%s\n%s\n\n' "##########################################################" "Set our install, setup and update scripts to be executable" "##########################################################"
sudo chmod +x /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/setup-ngxblocker
sudo chmod +x /usr/sbin/update-ngxblocker

# ********************
# Run setup-ngxblocker
# ********************

printf '\n%s\n%s\n%s\n\n' "####################" "Run setup-ngxblocker" "####################"
cd /usr/sbin
sudo bash ./setup-ngxblocker -x -c /etc/nginx/myconf.d -b /etc/nginx/mybots.d

# ************************
# Load our Nginx.conf file
# ************************

sudo nginx -c /etc/nginx/nginx.conf

# ******************************************************************************************
# Run update-ngxblocker test which downloads latest globalblacklist.conf and reloads Nginx
# This second test forces update-ngxblocker to re-write the Include location to non standard
# location of /etc/nginx/mybots.d
# ******************************************************************************************

# ****************************************************************************************
# Copy a dummy version of globalblacklist.conf with an older version number to test update
# ****************************************************************************************

printf '\n%s\n%s\n%s\n\n' "####################################################" "Copy older globalblacklist.conf file to force update" "####################################################"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/globalblacklist-dummy.conf /etc/nginx/myconf.d/globalblacklist.conf

# ****************************************************************************************
# Run update-ngxblocker test which downloads latest globalblacklist.conf and reloads Nginx
# ****************************************************************************************

printf '\n%s\n%s\n%s\n\n' "######################" "Run update-ngxblocker" "######################"
cd /usr/sbin
sudo bash ./update-ngxblocker -c /etc/nginx/myconf.d -b /etc/nginx/mybots.d -n

# *********************
# Force reload of Nginx
# *********************

printf '\n%s\n%s\n%s\n\n' "########################" "Force Reloading of Nginx" "########################"
sudo nginx -t && sudo nginx -s reload

# *******************************************************************************************
# Test that update-ngxblocker can install all missing required files by deleting some of them
# *******************************************************************************************

printf '\n%s\n%s\n%s\n\n' "####################################################################" "Delete existing files to force update-ngxblocker to re-download them" "####################################################################"
sudo rm /etc/nginx/myconf.d/*.conf
sudo rm /etc/nginx/mybots.d/*.conf

# *************************************
# List Directories to Confirm Deletions
# *************************************

printf '\n%s\n%s\n%s\n\n' "######################################################" "Confirming /usr/local/nginx/conf.d/ directory is EMPTY" "######################################################"
ls -la /etc/nginx/myconf.d/
printf '\n%s\n%s\n%s\n\n' "######################################################" "Confirming /usr/local/nginx/bots.d/ directory is EMPTY" "######################################################"
ls -la /etc/nginx/mybots.d/

# *********************************************************************************************************
# Run update-ngxblocker to test for missing files and download latest globalblacklist.conf and reload Nginx
# *********************************************************************************************************

printf '\n%s\n%s\n%s\n\n' "######################" "Run update-ngxblocker" "######################"
cd /usr/sbin
sudo bash ./update-ngxblocker -c /etc/nginx/myconf.d -b /etc/nginx/mybots.d -n

# ****************************************************
# List Directories to Confirm Downloaded Missing Files
# ****************************************************

printf '\n%s\n%s\n%s\n\n' "#############################################################################################" "Confirming /etc/nginx/myconf.d/ directory has missing files replaced by update-ngxblocker" "#############################################################################################"
ls -la /etc/nginx/myconf.d/
printf '\n%s\n%s\n%s\n\n' "#############################################################################################" "Confirming /etc/nginx/mybots.d/ directory has missing files replaced by update-ngxblocker" "#############################################################################################"
ls -la /etc/nginx/mybots.d/

# ****************************************************************************************
# Copy a dummy version of globalblacklist.conf with an older version number to test update
# ****************************************************************************************

printf '\n%s\n%s\n%s\n\n' "####################################################" "Copy older globalblacklist.conf file to force update" "####################################################"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/globalblacklist-dummy.conf /etc/nginx/myconf.d/globalblacklist.conf

# *********************************************************************************************************
# Run update-ngxblocker to test for missing files and download latest globalblacklist.conf and reload Nginx
# *********************************************************************************************************

printf '\n%s\n%s\n%s\n\n' "######################" "Run update-ngxblocker" "######################"
cd /usr/sbin
sudo bash ./update-ngxblocker -c /etc/nginx/myconf.d -b /etc/nginx/mybots.d -n

# **************************
# Run setup-ngxblocker Again
# **************************

printf '\n%s\n%s\n%s\n\n' "####################" "Run setup-ngxblocker" "####################"
cd /usr/sbin
sudo bash ./setup-ngxblocker -x -c /etc/nginx/myconf.d -b /etc/nginx/mybots.d

# *********************
# Force reload of Nginx
# *********************

printf '\n%s\n%s\n%s\n\n' "########################" "Force Reloading of Nginx" "########################"
sudo nginx -t && sudo nginx -s reload

# *******************************************************
# Make sure we test latest generated globalblacklist.conf
# *******************************************************

printf '\n%s\n%s\n%s\n\n' "##############################################################################" "Copy latest generated globalblacklist.conf file to test for any compile errors" "##############################################################################"
sudo cp ${TRAVIS_BUILD_DIR}/conf.d/globalblacklist.conf /etc/nginx/myconf.d/globalblacklist.conf

# **************************
# Run setup-ngxblocker Again
# **************************

printf '\n%s\n%s\n%s\n\n' "############################################################" "Run setup-ngxblocker to fix includes in globalblacklist.conf" "############################################################"
cd /usr/sbin
sudo bash ./setup-ngxblocker -x -c /etc/nginx/myconf.d -b /etc/nginx/mybots.d

# *********************
# Force reload of Nginx
# *********************

printf '\n%s\n%s\n%s\n\n' "########################" "Force Reloading of Nginx" "########################"
sudo nginx -t && sudo nginx -s reload

# **********************
# Now Run our Curl Tests
# **********************

printf '\n%s\n%s\n%s\n\n' "######################" "Now Run our Curl Tests" "######################"

# ************************************************************
# Copy all .conf files used in Test 3 to a folder for checking
# ************************************************************

sudo chown -R travis:travis ${TRAVIS_BUILD_DIR}/
sudo chown -R travis:travis ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_test3/
sudo cp /etc/nginx/mybots.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_test3/bots.d/
sudo cp /etc/nginx/myconf.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_test3/conf.d/
sudo cp /etc/nginx/sites-available/default.vhost ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_test3/default.vhost

# *****************************************************************************************
# Travis now moves into running the rest of the tests in the script: section of .travis.yml
# *****************************************************************************************

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
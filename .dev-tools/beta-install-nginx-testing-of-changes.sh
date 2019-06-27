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

# Run testing of test version

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

printf "\n"
echo "${bold}${yellow}-----------------------------------"
echo "${bold}${yellow}Delete Files to force fresh testing"
echo "${bold}${yellow}-----------------------------------"
printf "\n"
sudo rm /etc/nginx/conf.d/*.conf
sudo rm /etc/nginx/bots.d/*.conf
ls -la /etc/nginx/conf.d/
ls -la /etc/nginx/bots.d/

printf "\n"
echo "${bold}${magenta}-------------------------"
echo "${bold}${magenta}Execute update-ngxblocker"
echo "${bold}${magenta}-------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./update-ngxblocker -n


# ***********************************************************************
# Make sure we test latest generated globalblacklist-testing-version.conf
# ***********************************************************************

printf "\n"
echo "${bold}${yellow}---------------------------------------------------"
echo "${bold}${yellow}Copy Test Unit of globalblacklist.conf file to test"
echo "${bold}${yellow}---------------------------------------------------"
printf "\n"

sudo cp ${TRAVIS_BUILD_DIR}/conf.d/globalblacklist-testing-version.conf /etc/nginx/conf.d/globalblacklist.conf

# *********************
# Force reload of Nginx
# *********************

printf "\n"
echo "${bold}${green}------------"
echo "${bold}${green}Reload Nginx"
echo "${bold}${green}------------"
printf "\n"
sudo nginx -t && sudo nginx -s reload

# **********************
# Now Run our Curl Tests
# **********************

printf "\n"
echo "${bold}${green}---------------------------"
echo "${bold}${green}Run Bot and Referrer Checks"
echo "${bold}${green}---------------------------"
printf "\n"

# *************************************************************
# Copy all .conf files used in Testing to a folder for checking
# *************************************************************

printf "\n"
echo "${bold}${green}------------------------------------------------------------"
echo "${bold}${green}Make Backup all conf files and folders used during this test"
echo "${bold}${green}------------------------------------------------------------"
printf "\n"
sudo cp /etc/nginx/bots.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_testing_changes/bots.d/
sudo cp /etc/nginx/conf.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_testing_changes/conf.d/
sudo cp /etc/nginx/sites-available/default.vhost ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_testing_changes/default.vhost
sudo cp /etc/nginx/nginx.conf ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_testing_changes/nginx.conf

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
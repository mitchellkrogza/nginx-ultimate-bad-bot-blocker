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

# --------
# Log File
# --------

installub1804=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu1804-install.log
setupub1804=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu1804-setup.log
installub1604=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu1604-install.log
setupub1604=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu1604-setup.log
installarch=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/arch-install.log
setuparch=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/arch-setup.log

# ---------
# FUNCTIONS
# ---------

reloadNginX () {
printf "\n"
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

installngxblocker_ubuntu_1804 () {
echo "${bold}${magenta}------------------------------------------------------------------"
echo "${bold}${magenta}Execute install-ngxblocker - Ubuntu 18.04.2 LTS (Missing includes)"
echo "${bold}${magenta}------------------------------------------------------------------"
printf "\n"
cd /usr/sbin
# Reset Test
sudo rsync -avzh ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/unmodified/ubuntu-18.04/ ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-18.04/
sudo bash ./install-ngxblocker -x -c ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-18.04/etc/nginx/conf.d -b ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-18.04/etc/nginx/bots.d
}

setupngxblocker_ubuntu_1804 () {
printf "\n"
echo "${bold}${magenta}----------------------------------------------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker - Ubuntu 18.04.2 LTS (Missing includes)"
echo "${bold}${magenta}----------------------------------------------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./setup-ngxblocker -x -c ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-18.04/etc/nginx/conf.d -b ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-18.04/etc/nginx/bots.d -m ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-18.04/etc/nginx/nginx.conf
}

installngxblocker_ubuntu_1604 () {
echo "${bold}${magenta}------------------------------------------------------------------"
echo "${bold}${magenta}Execute install-ngxblocker - Ubuntu 16.04.6 LTS (Missing includes)"
echo "${bold}${magenta}------------------------------------------------------------------"
printf "\n"
cd /usr/sbin
# Reset Test
sudo rsync -avzh ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/unmodified/ubuntu-16.04/ ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-16.04/
sudo bash ./install-ngxblocker -x -c ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-16.04/etc/nginx/conf.d -b ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-16.04/etc/nginx/bots.d
}

setupngxblocker_ubuntu_1604 () {
printf "\n"
echo "${bold}${magenta}----------------------------------------------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker - Ubuntu 16.04.6 LTS (Missing includes)"
echo "${bold}${magenta}----------------------------------------------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./setup-ngxblocker -x -c ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-16.04/etc/nginx/conf.d -b ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-16.04/etc/nginx/bots.d -m ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/ubuntu-16.04/etc/nginx/nginx.conf
}

installngxblocker_arch () {
echo "${bold}${magenta}----------------------------------------------------------"
echo "${bold}${magenta}Execute install-ngxblocker - Arch Linux (Missing includes)"
echo "${bold}${magenta}----------------------------------------------------------"
printf "\n"
cd /usr/sbin
# Reset Test
sudo rsync -avzh ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/unmodified/arch/ ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/arch/
sudo bash ./install-ngxblocker -x -c ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/arch/etc/nginx/conf.d -b ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/arch/etc/nginx/bots.d
}

setupngxblocker_arch () {
printf "\n"
echo "${bold}${magenta}--------------------------------------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker - Arch Linux (Missing includes)"
echo "${bold}${magenta}--------------------------------------------------------"
printf "\n"
cd /usr/sbin
sudo bash ./setup-ngxblocker -x -c ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/arch/etc/nginx/conf.d -b ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/arch/etc/nginx/bots.d -m ${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/arch/etc/nginx/nginx.conf
}

# -----------------
# Trigger Functions
# -----------------

installngxblocker_ubuntu_1804 > ${installub1804}
setupngxblocker_ubuntu_1804 > ${setupub1804}
installngxblocker_ubuntu_1604 > ${installub1604}
setupngxblocker_ubuntu_1604 > ${setupub1604}
installngxblocker_arch > ${installarch}
setupngxblocker_arch > ${setuparch}

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

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
installcentos=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/centos-install.log
setupcentos=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/centos-setup.log
installfedora=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/fedora-install.log
setupfedora=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/fedora-setup.log
installopensuse=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/opensuse-install.log
setupopensuse=${TRAVIS_BUILD_DIR}/.dev-tools/distribution_tests_missing_includes/opensuse-setup.log

# ---------
# FUNCTIONS
# ---------

setup_ubuntu_1804 () {
printf "\n"
echo "${bold}${magenta}----------------------------------------------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker - Ubuntu 18.04.2 LTS (Missing includes)"
echo "${bold}${magenta}----------------------------------------------------------------"
printf "\n"
cp ${TRAVIS_BUILD_DIR}/.dev-tools/setup-ngxblocker/original/ubuntu18.conf ${TRAVIS_BUILD_DIR}/.dev-tools/setup-ngxblocker/original/ubuntu18.conf.modified 
sudo bash ${TRAVIS_BUILD_DIR}/.dev-tools/setup-ngxblocker/setup-ngxblocker -x -m ${TRAVIS_BUILD_DIR}/.dev-tools/setup-ngxblocker/original/ubuntu18.conf.modified
}

setup_ubuntu_1804MI () {
printf "\n"
echo "${bold}${magenta}----------------------------------------------------------------"
echo "${bold}${magenta}Execute setup-ngxblocker - Ubuntu 18.04.2 LTS (Missing includes)"
echo "${bold}${magenta}----------------------------------------------------------------"
printf "\n"
cp ${TRAVIS_BUILD_DIR}/.dev-tools/setup-ngxblocker/modified/ubuntu18.conf ${TRAVIS_BUILD_DIR}/.dev-tools/setup-ngxblocker/modified/ubuntu18.conf.modified 
sudo bash ${TRAVIS_BUILD_DIR}/.dev-tools/setup-ngxblocker/setup-ngxblocker -x -m ${TRAVIS_BUILD_DIR}/.dev-tools/setup-ngxblocker/modified/ubuntu18.conf.modified
}

# -----------------
# Trigger Functions
# -----------------

setup_ubuntu_1804
setup_ubuntu_1804MI

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

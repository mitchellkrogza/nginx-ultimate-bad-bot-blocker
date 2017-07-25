#!/bin/bash
# Travis CI Generating and Building for the Nginx Ultimate Bad Bot Blocker
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

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

# *************************************************
# Delete default site created by Nginx Installation
# *************************************************

sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
sudo rm /var/www/html/*

# ********************************************************
# Copy our default.vhost file into Nginx /sites-available/
# ********************************************************

sudo cp $TRAVIS_BUILD_DIR/.dev-tools/default.vhost /etc/nginx/sites-available/default.vhost

# **********************************************
# Link the vhost file into Nginx /sites-enabled/
# **********************************************

sudo ln -s /etc/nginx/sites-available/default.vhost /etc/nginx/sites-enabled/default.vhost

# ***********************************************************
# Copy our index.php file into the default site's root folder
# ***********************************************************

sudo cp $TRAVIS_BUILD_DIR/.dev-tools/index.php /var/www/html/index.php

# ***********************************************************************
# Download the Nginx Bad Bot Blocker setup files from the Live Repository
# ***********************************************************************

sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/sbin/install-ngxblocker
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/setup-ngxblocker -O /usr/sbin/setup-ngxblocker
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/update-ngxblocker -O /usr/sbin/update-ngxblocker

# **************************************************
# Set our install and setup scripts to be executable
# **************************************************

sudo chmod +x /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/setup-ngxblocker
sudo chmod +x /usr/sbin/update-ngxblocker

# **********************
# Run Install-NgxBlocker
# **********************

cd /usr/sbin
sudo ./install-ngxblocker -x

# ********************
# Run setup-ngxblocker
# ********************

cd /usr/sbin
sudo ./setup-ngxblocker -x

# ******************************************************************************************************
# NOTE: for Verbose Testing of any shell scripts use below format adding sh -x before running the script
# this helps a lot inside the TravisCI environment to see where a shell script may be failing 
# sudo sh -x ./setup-ngxblocker -x
# *******************************************************************************************************

# ************************
# Load our Nginx.conf file
# ************************

sudo nginx -c /etc/nginx/nginx.conf

# ****************************************************************************************
# Run update-ngxblocker test which downloads latest globalblacklist.conf and reloads Nginx
# ****************************************************************************************

cd /usr/sbin
sudo ./update-ngxblocker -e mitchellkrog@gmail.com

# *********************
# Force reload of Nginx
# *********************

sudo service nginx reload

# ***********************************************************
# Set all our other setup and deploy scripts to be executable
# ***********************************************************

sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/deploy-package.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-blacklist.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-robots.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-google-disavow.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-google-exclude.php
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-regex-format-referrers.php
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/modify-config-readme-files.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/modify-files-and-commit.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/run-curl-tests.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/run-curl-tests-2.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/prepare-robots-input.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/install-nginx-2.sh

# ************************************************************
# Copy all .conf files used in Test 1 to a folder for checking
# ************************************************************

cp /etc/nginx/bots.d/* $TRAVIS_BUILD_DIR/.dev-tools/_conf_files_test1/bots.d/
cp /etc/nginx/conf.d/* $TRAVIS_BUILD_DIR/.dev-tools/_conf_files_test1/conf.d/

# *****************************************************************************************
# Travis now moves into running the rest of the tests in the script: section of .travis.yml
# *****************************************************************************************

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
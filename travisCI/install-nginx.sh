#!/bin/bash
# Travis CI Testing for Nginx Ultimate Bad Bot Blocker
# https://github.com/mitchellkrogza

set -x

# Check Date - I only used this for testing to make sure I had set timezone correctly
# See .travis.yml file in the before_install section on how to set your timezone on TravisCI
#date

# Start Getting Nginx Ready for Testing the Nginx Bad Bot Blocker

# Delete default site created by Nginx Installation
sudo rm /etc/nginx/sites-available/default

# Download the Nginx Bad Bot Blocker files from the Live Repository
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/sbin/install-ngxblocker
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/setup-ngxblocker -O /usr/sbin/setup-ngxblocker
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/update-ngxblocker -O /usr/sbin/update-ngxblocker

# Set our install and setup scripts to be executable
sudo chmod +x /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/setup-ngxblocker
sudo chmod +x /usr/sbin/update-ngxblocker

# Run Install-NgxBlocker
cd /usr/sbin
sudo ./install-ngxblocker -x

# Copy our default.vhost file into Nginx /sites-available/
sudo cp $TRAVIS_BUILD_DIR/travisCI/default.vhost /etc/nginx/sites-available/default.vhost

# Link the vhost file into Nginx /sites-enabled/ and reload nginx
sudo ln -s /etc/nginx/sites-available/default.vhost /etc/nginx/sites-enabled/default.vhost
#sudo service nginx reload

# Run setup-ngxblocker
cd /usr/sbin
sudo ./setup-ngxblocker -x

# NOTE: for Verbose Testing of any shell scripts use below format adding sh -x before running the script
# this helps a lot inside the TravisCI environment to see where a shell script may be failing 
#sudo sh -x ./setup-ngxblocker -x

# Load our Nginx.conf file and reload Nginx
sudo nginx -c /etc/nginx/nginx.conf
#sudo service nginx reload

# Copy our index.php file into the default site's root folder
sudo cp $TRAVIS_BUILD_DIR/travisCI/index.php /var/www/html/index.php

# Run update-ngxblocker test
cd /usr/sbin
sudo ./update-ngxblocker

# Reload nginx - no need to do this as update-ngxblocker does this for us
#sudo service nginx reload

# Set all our other setup and deploy scripts to be executable
sudo chmod +x $TRAVIS_BUILD_DIR/travisCI/modify-globalblacklist.sh
sudo chmod +x $TRAVIS_BUILD_DIR/travisCI/deploy-package.sh
sudo chmod +x $TRAVIS_BUILD_DIR/travisCI/change-file.sh

# Travis now goes into the rest of the tests in the script: section of .travis.yml
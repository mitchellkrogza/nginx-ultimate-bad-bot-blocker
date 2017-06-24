#!/bin/bash
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
cd $TRAVIS_BUILD_DIR

#Remove Remotes Added by TravisCI
git remote rm origin

#Add Remote with Secure Key
git remote add origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git

#List Remotes ONLY DURING testing - do not do this on live repo / possible key leak
#git remote -v

# Set Git Variables
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
git config --global push.default simple

# Make sure we have master branch checked out in Git
git checkout master

# Modify our file and make sure Travis is owner
sudo $TRAVIS_BUILD_DIR/travisCI/modify-globalblacklist.sh
sudo $TRAVIS_BUILD_DIR/travisCI/modify-readme.sh
sudo chown -R travis:travis $TRAVIS_BUILD_DIR/*

# Add the modified file to the and commit it
#git add $TRAVIS_BUILD_DIR/README.md
#git add $TRAVIS_BUILD_DIR/AUTO-CONFIGURATION.md
#git add $TRAVIS_BUILD_DIR/MANUAL-CONFIGURATION.md
#git add $TRAVIS_BUILD_DIR/conf.d/globalblacklist.conf
#git add $TRAVIS_BUILD_DIR/_sample_config_files/Engintron_for_cPanel_WHM_Configuration_Example/etc/nginx/conf.d/globalblacklist.conf
git add -A
git commit -am "V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER [ci skip]"

# Travis now moves to the before_deploy: section of .travis.yml
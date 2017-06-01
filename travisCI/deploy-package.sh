#!/bin/bash
YEAR=$(date +"%Y")
MONTH=$(date +"%m")

# Make Sure we are in the Build Directory
cd $TRAVIS_BUILD_DIR

# Create our Version Number
export GIT_TAG=V3.$YEAR-$MONTH.$TRAVIS_BUILD_NUMBER

# Tag our release
git tag $GIT_TAG -a -m "V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER"

# Push our commit and tags back to the repo
sudo git push origin master && git push origin master --tags

# Uncomment to list all git folders and modified files etc
#ls -aR

# Now TravisCI moves into the deploy: section of TravisCI - see .travis.yml

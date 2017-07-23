#!/bin/bash
# TravisCI Package Deploy Script for the Nginx Ultimate Bad Bot Blocker
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

# ******************
# Set Some Variables
# ******************

YEAR=$(date +"%Y")
MONTH=$(date +"%m")

# ***************************************
# Make Sure we are in the Build Directory
# ***************************************

cd $TRAVIS_BUILD_DIR
sudo git remote -v

# *************************
# Create our Version Number
# *************************

export GIT_TAG=V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER

# ***************
# Tag our release
# ***************

git tag $GIT_TAG -a -m "V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER"

# *****************************************
# Push our commit and tags back to the repo
# *****************************************

sudo git push origin master && git push origin master --tags


# ***************************************************
# Try pushing changes to Google Ghost Spam Repository
# ***************************************************

cd /tmp/
sudo git clone https://github.com/mitchellkrogza/Stop.Google.Analytics.Ghost.Spam.HOWTO.git
sudo cp $TRAVIS_BUILD_DIR/_generator_lists/bad-referrers.list /tmp/Stop.Google.Analytics.Ghost.Spam.HOWTO/.dev-tools/_input_source/bad-referrers.list
ls -la /tmp/
cd /tmp/Stop.Google.Analytics.Ghost.Spam.HOWTO/
ls -la
sudo git remote -v
sudo git remote rm origin
sudo git remote add origin https://w7FDb+tofB5e+ej2GQDvOtlI75wADWuEsgYKCbiFnC4YKLGaN/NyNaAMuOdCPaLL6yWieHCTOQyG/zjVxZe8ST4R+2XQHv1x1PldbEHKnox+bAnrB9n3qZ0a8AOBtceI33gbrpL1wnZiVdcCh5HFlhvEOsiXhg+tc4BaIUZnA981dcf0EmIvWHWesmrgHVVh7x5Isgs5ecEpxyZZqn8FkHMgTnYe2s3IIlcIQhdvK2AhI33zz0fb1B9V/ll6UtAmbLKrYcN7waw/ZRzRDxuzJbCV6VCCFKzXo2DEs5NlEoa0P2bJAEj9dS5Q+1DGK5u1llbnycUBaS0phURb3gg8bcjX/9Ovlz/qnpw9EfimGxE7T6WjfI3sOQ9mFszgs/BigtZkay4ijGRNejrSiyC+/du/B0srto032HD8LTJBkbW5/OW9sr2JDmnOHJiceks4C8WYBVgvslLfnTD6tDgvJ88kjpk33Juq5ULm5ZcsJNQn+Dvn1btWQc1y9aRfktmyrTHoGTUXTx6c/YWXSdhuXVGCGgwxQ6PoOmhNeETuCKaA0dwoK1sACvgxJRDZCQpj7DneVGl7qqwr7LHQMrDMID+iXfr6ZMbFtC4HmK1PaDSxnPON/ecvEJLbUVRheo/70lYCYj2rlc7ytAUvMZ29Hzc353/GqF5FqxzX4kEubi8=@github.com/mitchellkrogza/Stop.Google.Analytics.Ghost.Spam.HOWTO.git
sudo git add -A
sudo git commit -am "Referrers (+)"
sudo git push origin master

# *************************************************************************
# Now TravisCI moves into the deploy: section of TravisCI - see .travis.yml
# *************************************************************************

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
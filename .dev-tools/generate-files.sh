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

# *****************************************************
# Set all our setup and deploy scripts to be executable
# *****************************************************

sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/deploy-package.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-blacklist.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-files.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-robots.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-google-disavow.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-google-exclude.php
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-regex-format-referrers.php
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/modify-config-readme-files.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/modify-files-and-commit.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/run-curl-tests-1.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/run-curl-tests-2.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/run-curl-tests-3.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/run-curl-tests-4.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/prepare-robots-input.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/install-nginx-1.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/install-nginx-2.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/install-nginx-3.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/install-nginx-4.sh

cd $TRAVIS_BUILD_DIR

# ***************************************************
# Modify our files with build and version information
# ***************************************************

php ./.dev-tools/generate-regex-format-referrers.php
sudo $TRAVIS_BUILD_DIR/.dev-tools/generate-blacklist.sh
sudo $TRAVIS_BUILD_DIR/.dev-tools/modify-config-readme-files.sh
sudo $TRAVIS_BUILD_DIR/.dev-tools/prepare-robots-input.sh
sudo $TRAVIS_BUILD_DIR/.dev-tools/generate-robots.sh
sudo $TRAVIS_BUILD_DIR/.dev-tools/generate-google-disavow.sh
php ./.dev-tools/generate-google-exclude.php


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
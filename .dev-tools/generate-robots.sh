#!/bin/bash
# Generator Script for the Nginx Ultimate Bad Bot Blocker
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

# Generate a robots.txt file for those unable to use the full Nginx Ultimate Bad Bot Blocker

#########################################################################                                                                
#        _  __     _                                                    #
#       / |/ /__ _(_)__ __ __                                           #
#      /    / _ `/ / _ \\ \ /                                           #
#     /_/|_/\_, /_/_//_/_\_\                                            #
#        __/___/      __  ___       __    ___  __         __            #
#       / _ )___ ____/ / / _ )___  / /_  / _ )/ /__  ____/ /_____ ____  #
#      / _  / _ `/ _  / / _  / _ \/ __/ / _  / / _ \/ __/  '_/ -_) __/  #
#     /____/\_,_/\_,_/ /____/\___/\__/ /____/_/\___/\__/_/\_\\__/_/     #
#########################################################################  

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

# ***************
# Set Input Files
# ***************

_input1=$TRAVIS_BUILD_DIR/.dev-tools/_robots_input/robots-input.txt
_tmprobots=/tmp/robots.txt

# ******************
# Set Some Variables
# ******************

YEAR=$(date +"%Y")
MONTH=$(date +"%m")
MY_GIT_TAG=V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER
BAD_REFERRERS=$(wc -l < $TRAVIS_BUILD_DIR/_generator_lists/bad-referrers.list)
BAD_BOTS=$(wc -l < $TRAVIS_BUILD_DIR/_generator_lists/bad-user-agents.list)
_now="$(date)"

# *************************
# Set Start and End Markers
# *************************

_startmarker="### Version Information #"
_endmarker="### Version Information ##"


# **************************
# Create the robots.txt file
# **************************

printf '%s\n%s\n%s%s\n%s%s\n%s%s\n%s\n%s\n\n%s\n%s\n%s\n' "$_startmarker" "###################################################" "### Version: " "$MY_GIT_TAG" "### Updated: " "$_now" "### Bad Bot Count: " "$BAD_BOTS" "###################################################" "$_endmarker" "User-agent: *" "Disallow: /wp-admin/" "Allow: /wp-admin/admin-ajax.php" >> "$_tmprobots"
while IFS= read -r LINE
do
printf 'User-agent: %s\n%s\n' "${LINE}" "Disallow:/" >> "$_tmprobots"
done < $_input1
printf '\n' >> "$_tmprobots"
sudo cp $_tmprobots $TRAVIS_BUILD_DIR/robots.txt/robots.txt
exit 0

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
#!/bin/bash
# Generator Script for the Nginx Ultimate Bad Bot Blocker
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

# Generate a robots.txt file for those unable to use the full Nginx Ultimate Bad Bot Blocker

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

_input4a=$TRAVIS_BUILD_DIR/_generator_lists/bad-user-agents.list
_robotsinput1=/tmp/robotsinput1.txt
_robotsinput1b=/tmp/robotsinput1b.txt
_tmprobots=/tmp/robots.txt

# ******************
# Set Some Variables
# ******************

YEAR=$(date +"%Y")
MONTH=$(date +"%m")
MY_GIT_TAG=V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER
BAD_REFERRERS=$(wc -l < $TRAVIS_BUILD_DIR/_generator_lists/bad-referrers.list)
BAD_BOTS=$(wc -l < $TRAVIS_BUILD_DIR/_generator_lists/bad-user-agents.list)
now="$(date)"

# *************************
# Set Start and End Markers
# *************************

_startmarker="### Version Information #"
_endmarker="### Version Information ##"


# **************************
# Create the robots.txt file
# **************************

cp $_input4a $_robotsinput1
sed 's/[\]//g' $_robotsinput1 > $_robotsinput1b
IFS=''
echo $_startmarker  >> $_tmprobots
printf "###################################################\n### Version: "$MY_GIT_TAG"\n### Updated: "$now"\n### Bad Referrer Count: "$BAD_REFERRERS"\n### Bad Bot Count: "$BAD_BOTS"\n###################################################\n" >> $_tmprobots
echo $_endmarker  >> $_tmprobots
printf "\n\n" >> $_tmprobots
cat $_robotsinput1b |
while read line; do
printf 'User-agent: '${line}'\n Disallow:/ \n' >> $_tmprobots
done
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